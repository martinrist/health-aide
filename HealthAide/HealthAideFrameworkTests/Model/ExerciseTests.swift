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
    let ex = Exercise(name: "name", description: "description")
    XCTAssertEqual(ex.name, "name")
    XCTAssertEqual(ex.description, "descriptionxxx")
  }

}
