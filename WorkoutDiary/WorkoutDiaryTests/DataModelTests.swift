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

  // MARK: - Setup and Teardown

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

}



// MARK: - Lifecycle Tests

extension DataModelTests {
  func testDataModel_NewModel_ContainsNoData() {
    XCTAssert(sut.routines.count == 0)
  }
}


// MARK: - Persistence Tests

extension DataModelTests {
  func testDataModel_LoadData_OneRoutine_NoExercises() {
    let testDataFile = testJsonFile(category: "dataModel", testCase: "oneRoutine-noExercises")
    sut.loadData(from: testDataFile!)
    XCTAssertEqual(sut.routines.count, 1)
    let routine = sut.routines[0]
    XCTAssertEqual(routine.name, "Routine 1")
    XCTAssertEqual(routine.description, "Routine 1 Description")
    XCTAssertEqual(routine.exercises.count, 0)
  }


  private func testJsonFile(category: String, testCase: String) -> URL? {
    let filename = "\(category)-\(testCase)"
    let testBundle = Bundle(for: type(of: self))
    if let url = testBundle.url(forResource: filename, withExtension: "json") {
      return url
    } else {
      XCTFail("Unable to find test file \(filename).json")
      return nil
    }
  }


}
