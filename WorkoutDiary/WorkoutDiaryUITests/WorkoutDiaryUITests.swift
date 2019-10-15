//
//  WorkoutDiaryUITests.swift
//  WorkoutDiaryUITests
//
//  Created by Martin Rist on 09/09/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import XCTest

class WorkoutDiaryUITests: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    super.setUp()

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    app = XCUIApplication()
    app.launch()

  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testStartup_ShowsExerciseListHeader() {
    XCTAssertTrue(app.staticTexts["Exercises"].exists)
  }

}
