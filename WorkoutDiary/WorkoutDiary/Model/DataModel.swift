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
    // No-op for now - just a stub where test data can be added
  }

}
