//
//  DataModel.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 15/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import Foundation

class DataModel {

  // MARK: - Properties

  var exercises = [Exercise]()

  // MARK: - Lifecycle

  init() {
    loadExercises()
  }
}

// MARK: - Test Data

extension DataModel {

  func loadExercises() {
    // For now, just populate with dummy test data
    exercises = (1...5).map {
      Exercise(name: "Exercise \($0)", description: "Description of Exercise \($0)")
    }
  }

}
