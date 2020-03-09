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
      = Pace.fromMinutes(minutes: minutes)
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
      = fromMinutes(minutes: minutes)
    return Pace.perKm(minutes: integerMinutes, seconds: integerSeconds)
  }

  public static func perMile(minutes: Int, seconds: Int) -> Pace {
    Pace(minutes: minutes, seconds: seconds, unit: .mile)
  }

  public static func perMile(minutes: Double) -> Pace {
    let (integerMinutes, integerSeconds)
      = fromMinutes(minutes: minutes)
    return Pace.perMile(minutes: integerMinutes, seconds: integerSeconds)
  }

  private static func toMinutes(minutes: Int, seconds: Int) -> Double {
    Double(minutes) + Double(seconds) / 60
  }

  private static func fromMinutes(minutes: Double)
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
      return .perKm(minutes: self.inMinutes() * 5 / 8)
    }
  }

  public func perMile() -> Pace {
    switch self.unit {
    case .kilometer:
      return .perMile(minutes: self.inMinutes() * 8 / 5)
    case .mile:
      return self
    }
  }

  func inMinutes() -> Double {
    Double(minutes) + (Double(seconds) / 60)
  }

  static func / (pace: Pace, _ by: Double) -> Pace {
    Pace(minutes: pace.inMinutes() / by, unit: pace.unit)
  }

  public func averaged(with other: Pace) -> Pace {
    (self + other) / 2
  }

}


extension Double {
  public func percent(of basePace: Pace) -> Pace {
    let newPaceInMinutes = basePace.inMinutes() * 100 / Double(self)
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
    let (minutes, seconds) = Pace.fromMinutes(minutes: value)
    self.minutes = minutes
    self.seconds = seconds
    self.unit = .kilometer
  }
}


extension Pace: Equatable {
  public static func == (lhs: Pace, rhs: Pace) -> Bool {
    return lhs.perKm().inMinutes() == rhs.perKm().inMinutes()
  }
}


extension Pace: Comparable {
  public static func < (lhs: Pace, rhs: Pace) -> Bool {
    return lhs.perKm().inMinutes() > rhs.perKm().inMinutes()
  }
}

extension Pace: AdditiveArithmetic {

  public static func + (lhs: Pace, rhs: Pace) -> Pace {
    let lhsMinutes = lhs.perKm().inMinutes()
    let rhsMinutes = rhs.perKm().inMinutes()
    let totalPace = Pace(minutes: lhsMinutes - rhsMinutes, unit: .kilometer)

    switch lhs.unit {
    case .kilometer:
      return totalPace
    case .mile:
      return totalPace.perMile()
    }
  }

  public static func - (lhs: Pace, rhs: Pace) -> Pace {
    let lhsMinutes = lhs.perKm().inMinutes()
    let rhsMinutes = rhs.perKm().inMinutes()
    let paceDifference = Pace(minutes: lhsMinutes + rhsMinutes, unit: .kilometer)

    switch lhs.unit {
    case .kilometer:
      return paceDifference
    case .mile:
      return paceDifference.perMile()
    }
  }

  public static func += (lhs: inout Pace, rhs: Pace) {
    let lhsMinutes = lhs.perKm().inMinutes()
    let rhsMinutes = rhs.perKm().inMinutes()
    let paceSum = Pace(minutes: lhsMinutes - rhsMinutes, unit: .kilometer)

    switch lhs.unit {
    case .kilometer:
      lhs = paceSum
    case .mile:
      lhs = paceSum.perMile()
    }
  }

  public static func -= (lhs: inout Pace, rhs: Pace) {
    let lhsMinutes = lhs.perKm().inMinutes()
    let rhsMinutes = rhs.perKm().inMinutes()
    let paceDifference = Pace(minutes: lhsMinutes + rhsMinutes, unit: .kilometer)

    switch lhs.unit {
    case .kilometer:
      lhs = paceDifference
    case .mile:
      lhs = paceDifference.perMile()
    }
  }
}
