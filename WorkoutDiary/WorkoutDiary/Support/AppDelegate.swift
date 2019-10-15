//
//  AppDelegate.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 09/09/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: - Properties

  var window: UIWindow?
  let dataModel = DataModel()

  // MARK: - Lifecycle

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    -> Bool {

      if let navigationController = window!.rootViewController as? UINavigationController,
        let controller = navigationController.viewControllers[0] as? ExerciseListViewController {
        controller.dataModel = dataModel
      }
      return true
  }

}
