import Foundation

typealias Length = Measurement<UnitLength>
typealias Mass = Measurement<UnitMass>
typealias Duration = Measurement<UnitDuration>

let distanceCentimetres = Length(value: 225, unit: .centimeters)
let distanceInches = distanceCentimetres.converted(to: .inches)

let weightPounds = Mass(value: 140, unit: .pounds)

Mass(value: 67, unit: .kilograms)
  .converted(to: .stones)

extension Measurement where UnitType == UnitMass {
  func convertedToStonesAndPounds() -> (stones: Int, pounds: Int) {
    let inPounds = self.converted(to: .pounds)
    return (Int(inPounds.value / 14), Int(inPounds.value.truncatingRemainder(dividingBy: 14)))
  }
}

extension Duration {
  func convertedToMinutesAndSeconds() -> (minutes: Int, seconds: Double) {
    let inSeconds = self.converted(to: .seconds)
    return (Int(inSeconds.value / 60),
            inSeconds.value.truncatingRemainder(dividingBy: 60))
  }

  static func from(minutes: Double, seconds: Double) -> Duration {
    Duration(value: minutes, unit: .minutes)
    + Duration(value: seconds, unit: .seconds)
  }
}


let fourMinutesThirtySeconds = Duration.from(minutes: 4, seconds: 30)

fourMinutesThirtySeconds.convertedToMinutesAndSeconds()

Mass(value: 139, unit: .pounds).convertedToStonesAndPounds()
Mass(value: 139, unit: .kilograms).convertedToStonesAndPounds()
Mass(value: 10, unit: .stones).convertedToStonesAndPounds()
Mass(value: 10, unit: .stones).converted(to: .pounds)

Mass(value: 67, unit: .kilograms).convertedToStonesAndPounds()

let formatter = MeasurementFormatter()
formatter.locale = Locale(identifier: "en_GB")
formatter.string(from: Mass(value: 149, unit: .pounds))



/// What is 5:51 per km as a speed?

let fiveFiftyOne = Duration.from(minutes: 5, seconds: 51)
let oneKm = Length(value: 1, unit: .kilometers)

// TODO: This is what we need Ampere for I think
// fiveFiftyOne / oneKm


// TODO: Rewrite these expressions using swift-prelude operators?

let fiveFiftyOnePerKm = Measurement<UnitSpeed>(value: 1000 / fiveFiftyOne.value, unit: .metersPerSecond)

let sixThirtyNinePerKm = Measurement<UnitSpeed>(value: 1000 / (Duration.from(minutes: 6, seconds: 39)).value, unit: .metersPerSecond)

let midpoint = (fiveFiftyOnePerKm + sixThirtyNinePerKm) / 2

Duration(value: 1000 / midpoint.value, unit: .seconds).convertedToMinutesAndSeconds()


