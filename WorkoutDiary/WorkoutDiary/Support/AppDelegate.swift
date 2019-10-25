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
  let dataModel = DataModel(fromFilePath: DataModel.dataFilePath())


  // MARK: - Lifecycle

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    -> Bool {

      if let navigationController = window!.rootViewController as? UINavigationController,
        let controller = navigationController.viewControllers[0] as? RoutineListViewController {
        controller.dataModel = dataModel
      }
      return true
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    saveData()
  }

  func applicationWillTerminate(_ application: UIApplication) {
    saveData()
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    loadData()
  }

}



// MARK: - Persistence Helpers

extension AppDelegate {

  private func saveData() {
    let dataFile = DataModel.dataFilePath()
    print("Saving data to: \(dataFile)")
    dataModel.saveData(to: dataFile)
  }

  private func loadData() {
    let dataFile = DataModel.dataFilePath()
    print("Loading data from: \(dataFile)")
    dataModel.loadData(from: dataFile)
  }

}
