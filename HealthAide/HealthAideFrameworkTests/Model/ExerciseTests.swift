//
//  ExerciseTests.swift
//  HealthAideFrameworkTests
//
//  Created by Martin Rist on 24/02/2020.
//  Copyright © 2020 Martin Rist. All rights reserved.
//

import XCTest
import HealthAideFramework

class ExerciseTests: XCTestCase {

  func testInitialisation() {
    let exercise = Exercise(name: "name", description: "description")
    XCTAssertEqual(exercise.name, "name")
    XCTAssertEqual(exercise.description, "description")
  }

}
