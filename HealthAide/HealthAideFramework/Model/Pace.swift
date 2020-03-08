//
//  Pace.swift
//  HealthAideFramework
//
//  Created by Martin Rist on 08/03/2020.
//  Copyright © 2020 Martin Rist. All rights reserved.
//

import Foundation

public struct Pace {

  enum Unit: String {
    case kilometer = "km"
    case mile = "mi"
  }

  let minutes: Int
  let seconds: Int
  let unit: Unit


  // MARK: - Internal Constructors

  init(minutes: Int, seconds: Int, unit: Unit = .kilometer) {
    self.minutes = minutes
    self.seconds = seconds
    self.unit = unit
  }

  init(minutes: Double, unit: Unit) {
    let (minutesComponent, secondsComponent)
      = Pace.fromFractionalMinutes(minutes: minutes)
    self.minutes = minutesComponent
    self.seconds = secondsComponent
    self.unit = unit
  }


  // MARK: - Static factory methods

  public static func perKm(minutes: Int, seconds: Int) -> Pace {
    Pace(minutes: minutes, seconds: seconds, unit: .kilometer)
  }

  public static func perKm(minutes: Double) -> Pace {
    let (integerMinutes, integerSeconds)
      = fromFractionalMinutes(minutes: minutes)
    return Pace.perKm(minutes: integerMinutes, seconds: integerSeconds)
  }

  public static func perMile(minutes: Int, seconds: Int) -> Pace {
    Pace(minutes: minutes, seconds: seconds, unit: .mile)
  }

  public static func perMile(minutes: Double) -> Pace {
    let (integerMinutes, integerSeconds)
      = fromFractionalMinutes(minutes: minutes)
    return Pace.perMile(minutes: integerMinutes, seconds: integerSeconds)
  }

  private static func toFractionalMinutes(minutes: Int, seconds: Int) -> Double {
    Double(minutes) + Double(seconds) / 60
  }

  private static func fromFractionalMinutes(minutes: Double)
    -> (minutes: Int, seconds: Int) {
      let integerMinutes = Int(minutes)
      let integerSeconds = Int((minutes - Double(integerMinutes)) * 60)
      return (integerMinutes, integerSeconds)
  }


  // MARK: - Conversion functions

  public func perKm() -> Pace {
    switch self.unit {
    case .kilometer:
      return self
    case .mile:
      return .perKm(minutes: self.fractionalMinutes() * 5 / 8)
    }
  }

  public func perMile() -> Pace {
    switch self.unit {
    case .kilometer:
      return .perMile(minutes: self.fractionalMinutes() * 8 / 5)
    case .mile:
      return self
    }
  }

  func fractionalMinutes() -> Double {
    Double(minutes) + (Double(seconds) / 60)
  }

  static func / (pace: Pace, _ by: Double) -> Pace {
    Pace(minutes: pace.fractionalMinutes() / by, unit: pace.unit)
  }

  public func averaged(with other: Pace) -> Pace {
    (self + other) / 2
  }

}


extension Double {
  public func percent(of basePace: Pace) -> Pace {
    let newPaceInMinutes = basePace.fractionalMinutes() * 100 / Double(self)
    return Pace(minutes: newPaceInMinutes, unit: basePace.unit)
  }
}


extension Pace: CustomPlaygroundDisplayConvertible {
  public var playgroundDescription: Any {
    return String(format: "%d:%02d", minutes, seconds) + " / \(unit.rawValue)"
  }
}

extension Pace: ExpressibleByIntegerLiteral {
  public typealias IntegerLiteralType = Double

  public init(integerLiteral value: Double) {
    let (minutes, seconds) = Pace.fromFractionalMinutes(minutes: value)
    self.minutes = minutes
    self.seconds = seconds
    self.unit = .kilometer
  }
}


extension Pace: Equatable {
  public static func == (lhs: Pace, rhs: Pace) -> Bool {
    switch lhs.unit {
    // TODO: We need a function here (and elsewhere) to convert two paces to common base
    case .kilometer:
      return lhs.fractionalMinutes() == rhs.perKm().fractionalMinutes()
    case .mile:
      return lhs.fractionalMinutes() == rhs.perMile().fractionalMinutes()
    }
  }
}


extension Pace: Comparable {
  public static func < (lhs: Pace, rhs: Pace) -> Bool {
    switch lhs.unit {
    // TODO: We need a function here (and elsewhere) to convert two paces to common base
    case .kilometer:
      return lhs.fractionalMinutes() < rhs.perKm().fractionalMinutes()
    case .mile:
      return lhs.fractionalMinutes() < rhs.perMile().fractionalMinutes()
    }
  }
}

extension Pace: AdditiveArithmetic {

  public static func + (lhs: Pace, rhs: Pace) -> Pace {
    let lhsMinutes = lhs.perKm().fractionalMinutes()
    let rhsMinutes = rhs.perKm().fractionalMinutes()
    let totalPace = Pace(minutes: lhsMinutes + rhsMinutes, unit: .kilometer)

    switch lhs.unit {
    case .kilometer:
      return totalPace
    case .mile:
      return totalPace.perMile()
    }
  }

  public static func - (lhs: Pace, rhs: Pace) -> Pace {
    let lhsMinutes = lhs.perKm().fractionalMinutes()
    let rhsMinutes = rhs.perKm().fractionalMinutes()
    let paceDifference = Pace(minutes: lhsMinutes - rhsMinutes, unit: .kilometer)

    switch lhs.unit {
    case .kilometer:
      return paceDifference
    case .mile:
      return paceDifference.perMile()
    }
  }

  public static func += (lhs: inout Pace, rhs: Pace) {
    let lhsMinutes = lhs.perKm().fractionalMinutes()
    let rhsMinutes = rhs.perKm().fractionalMinutes()
    let paceSum = Pace(minutes: lhsMinutes + rhsMinutes, unit: .kilometer)

    switch lhs.unit {
    case .kilometer:
      lhs = paceSum
    case .mile:
      lhs = paceSum.perMile()
    }
  }

  public static func -= (lhs: inout Pace, rhs: Pace) {
    let lhsMinutes = lhs.perKm().fractionalMinutes()
    let rhsMinutes = rhs.perKm().fractionalMinutes()
    let paceDifference = Pace(minutes: lhsMinutes - rhsMinutes, unit: .kilometer)

    switch lhs.unit {
    case .kilometer:
      lhs = paceDifference
    case .mile:
      lhs = paceDifference.perMile()
    }
  }
}
