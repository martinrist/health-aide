//
//  ExerciseListViewController.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 15/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import UIKit

class ExerciseListViewController: UITableViewController {

  // MARK: - Cell Reuse Identifiers

  enum CellIdentifier: String {
    case exerciseCell
  }

  // MARK: - Properties

  var dataModel: DataModel!

}

// MARK: - Table View Data Source

extension ExerciseListViewController {

  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return dataModel.exercises.count
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.exerciseCell.rawValue,
                                             for: indexPath)

    let exercise = dataModel.exercises[indexPath.row]
    configureCell(cell, with: exercise)

    return cell
  }

  private func configureCell(_ cell: UITableViewCell, with exercise: Exercise) {
    cell.textLabel!.text = exercise.name
    cell.detailTextLabel!.text = exercise.description
  }

}
