//
//  ExerciseListViewController.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 15/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import UIKit

class ExerciseListViewController: UITableViewController {


  // MARK: - Segue Identifiers

  enum SegueIdentifier: String {
    case addExercise
    case editExercise
  }


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



// MARK: - Navigation

extension ExerciseListViewController {

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identString = segue.identifier,
      let identifier = ExerciseListViewController.SegueIdentifier(rawValue: identString) else { return }

    switch identifier {

    case .addExercise:
      // swiftlint:disable:next force_cast
      let controller = segue.destination as! ExerciseDetailViewController
      controller.delegate = self

    case .editExercise:
      // swiftlint:disable:next force_cast
      let controller = segue.destination as! ExerciseDetailViewController
      controller.delegate = self
      if let sender = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: sender) {
        controller.exerciseToEdit = dataModel.exercises[indexPath.row]
      }
    }
  }
}



// MARK: - ExerciseDetailViewControllerDelegate

extension ExerciseListViewController: ExerciseDetailViewControllerDelegate {

  func exerciseDetailViewControllerDidCancel(_ controller: ExerciseDetailViewController) {
    navigationController?.popViewController(animated: true)
  }

  func exerciseDetailViewController(_ controller: ExerciseDetailViewController,
                                    didFinishAdding exercise: Exercise) {

    // Update model
    dataModel.exercises.append(exercise)

    // Update view
    let newRowIndex = dataModel.exercises.count - 1
    let newIndexPath = IndexPath(item: newRowIndex, section: 0)
    tableView.insertRows(at: [newIndexPath], with: .automatic)

    // Pop the 'add' screen off
    navigationController?.popViewController(animated: true)
  }

  func exerciseDetailViewController(_ controller: ExerciseDetailViewController,
                                    didFinishEditing oldExercise: Exercise,
                                    to newExercise: Exercise) {

    if let index = dataModel.exercises.firstIndex(of: oldExercise) {

      // Update model
      dataModel.exercises.remove(at: index)
      dataModel.exercises.insert(newExercise, at: index)

      // Update view
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureCell(cell, with: newExercise)
      }
    }

    // Pop the 'edit' screen off
    navigationController?.popViewController(animated: true)
  }
}
