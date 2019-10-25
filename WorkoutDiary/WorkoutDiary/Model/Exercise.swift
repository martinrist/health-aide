//
//  Exercise.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 15/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import Foundation

class Exercise: Equatable, Codable {

  var name: String
  var description: String

  init(name: String, description: String) {
    self.name = name
    self.description = description
  }

  static func == (lhs: Exercise, rhs: Exercise) -> Bool {
    return lhs.name == rhs.name
      && lhs.description == rhs.description
  }

}
