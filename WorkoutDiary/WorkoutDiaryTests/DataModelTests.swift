//
//  DataModelTests.swift
//  WorkoutDiaryTests
//
//  Created by Martin Rist on 15/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import XCTest

class DataModelTests: XCTestCase {

  let sut = DataModel()

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testDataModel_ContainsExpectedTestData() {
    XCTAssert(sut.exercises.count == 5)
  }
}
