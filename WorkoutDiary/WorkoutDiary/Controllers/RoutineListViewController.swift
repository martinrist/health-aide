//
//  RoutineListViewController.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 23/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import UIKit

class RoutineListViewController: UITableViewController {

  // MARK: - Segue Identifiers

  enum SegueIdentifier: String {
    case showRoutine
  }



  // MARK: - Cell Reuse Identifiers

  enum CellIdentifier: String {
    case routineCell
  }


  // MARK: - Properties

  var dataModel: DataModel!


  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }


}



// MARK: - Table view data source

extension RoutineListViewController {

  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return dataModel.routines.count
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.routineCell.rawValue,
                                             for: indexPath)

    let routine = dataModel.routines[indexPath.row]
    configureCell(cell, with: routine)

    return cell
  }


  private func configureCell(_ cell: UITableViewCell,
                             with routine: Routine) {
    cell.textLabel!.text = routine.name
    // TODO: Add number of exercises
  }


  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    // TODO: Add implementation
  }


}



// MARK: - Navigation

extension RoutineListViewController {

  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {

    guard let identString = segue.identifier,
      let identifier = RoutineListViewController.SegueIdentifier(rawValue: identString) else {
        return }

    switch identifier {

    case .showRoutine:
      // swiftlint:disable:next force_cast
      let controller = segue.destination as! ExerciseListViewController
      if let sender = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: sender) {
        controller.routine = dataModel.routines[indexPath.row]
      }

    }
  }
}
