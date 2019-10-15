//
//  ExerciseDetailViewController.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 15/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import UIKit

protocol ExerciseDetailViewControllerDelegate: class {
  func exerciseDetailViewControllerDidCancel(_ controller: ExerciseDetailViewController)
  func exerciseDetailViewController(_ controller: ExerciseDetailViewController,
                                    didFinishAdding item: Exercise)
}

class ExerciseDetailViewController: UITableViewController {

  // MARK: - Properties

  weak var delegate: ExerciseDetailViewControllerDelegate?
  var exerciseToEdit: Exercise?

  // MARK: - Outlets

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    nameTextField.becomeFirstResponder()
  }

  // MARK: - Actions

  @IBAction func cancel(_ sender: Any) {
    delegate?.exerciseDetailViewControllerDidCancel(self)
  }

  @IBAction func done(_ sender: Any) {
    let exercise = Exercise(name: nameTextField.text!,
                            description: descriptionTextField.text!)
    delegate?.exerciseDetailViewController(self,
                                           didFinishAdding: exercise)
  }
}

// MARK: - UITableViewDelegate

extension ExerciseDetailViewController {

  override func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    // Prevents the rows behind the text fields being selected
    return nil
  }
}

// MARK: - UITextFieldDelegate

extension ExerciseDetailViewController: UITextFieldDelegate {

  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {

    // Work out what the 'new' text would be
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: string)

    // Disable the 'done' button if the new text is empty
    doneBarButton.isEnabled = !newText.isEmpty

    return true
  }
}
