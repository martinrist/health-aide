import UIKit
import HealthAideFramework

// MARK: - Pace

let fiveMinKm: Pace = .perKm(minutes: 5)
fiveMinKm.perMile()
90.percent(of: fiveMinKm)

let fourMinMile: Pace = .perMile(minutes: 4)
fourMinMile.perKm()

let prettyFast: Pace = .perKm(minutes: 4, seconds: 36)
prettyFast.perMile()


let easyRecoveryHigh = Pace.perMile(minutes: 10, seconds: 50).perKm()


let fiveKPace = Pace.perMile(minutes: 7, seconds: 39)
let surgePace = 90.percent(of: fiveKPace)

let tenMinKm: Pace = 10

fiveMinKm.averaged(with: tenMinKm)


// Equality & Comparison

let anotherFiveMinuteKm = Pace.perKm(minutes: 5)
let eightMinuteMile = Pace.perMile(minutes: 8)
fiveMinKm == anotherFiveMinuteKm
fiveMinKm == eightMinuteMile
fiveMinKm == prettyFast

let fourMinKm = Pace.perKm(minutes: 4)
let sixMinKm = Pace.perKm(minutes: 6)

// Less means slower
fiveMinKm < sixMinKm
fiveMinKm < fourMinKm

fiveMinKm > sixMinKm

// Faster and slower

let twoMinKm = Pace.perKm(minutes: 2)
let twoMinFasterThanFiveMin = fiveMinKm + twoMinKm
let twoMinSlowerThanFiveMin = fiveMinKm - twoMinKm
