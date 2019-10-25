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

  var routines = [Routine]()

  // MARK: - Lifecycle

  init() {
    // Empty constructor for creating an empty model
  }

  init(fromFilePath dataFile: URL) {
    print("Loading initial data from: \(dataFile)")
    loadData(from: dataFile)
  }
}



// MARK: - Persistence

extension DataModel {

  func loadData(from url: URL) {
    if let data = try? Data(contentsOf: url) {
      let decoder = JSONDecoder()
      do {
        routines = try decoder.decode([Routine].self,
                                      from: data)
      } catch {
        print("Error decoding data: \(error)")
      }
    }
  }

  func saveData(to url: URL) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do {
      let data = try encoder.encode(routines)
      try data.write(to: url,
                     options: Data.WritingOptions.atomic)
    } catch {
      print("Error encoding item array: \(error)")
    }
  }

  static func documentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory,
                             in: .userDomainMask)[0]
  }

  static func dataFilePath() -> URL {
    documentsDirectory().appendingPathComponent("workoutDiary-routines.json")
  }

}
