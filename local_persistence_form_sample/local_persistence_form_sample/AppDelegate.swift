//
//  AppDelegate.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//

import UIKit
import CoreData
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let cleanHandlerIdentifier = "com.local-persistence-form-sample.db_cleaning_debug"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //MARK: Register Cleaner Handler
        BGTaskScheduler.shared
            .register(
                forTaskWithIdentifier: cleanHandlerIdentifier,
                using: nil
            ) {
                [weak self] task in
                print("Registering", self?.cleanHandlerIdentifier ?? "")
                self?.handleDatabaseCleaning(with: task as! BGProcessingTask)
            }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = CoreDataStack.shared.newBackgroundContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// MARK: - Database cleaning handler and BGTask Scheduler
extension AppDelegate {
    private func handleDatabaseCleaning(with task: BGProcessingTask) {
        task.expirationHandler = {
            print("Background Database Cleaning expired")
        }
        Task {
            defer {
                task.setTaskCompleted(success: true)
            }

            let predicate = NSPredicate(format: "timestamp < %@", NSDate(timeIntervalSinceNow: 60))
            let users = CoreDataStack.shared.fetchUsers(predicate: predicate)
            guard !users.isEmpty else {
                print("No users")
                task.setTaskCompleted(success: true)
                return
            }
            for user in users {
                let result = await CoreDataStack.shared.delete(item: user)
                switch (result) {
                case .success(let check):
                    print(check ? "Deleted successfuly" : "No object found")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func scheduleDatabaseCleaning() {
        let lastCleanDate = CoreDataStack.shared.lastCleaned ?? .distantPast
        let now = Date()
        let oneWeek = TimeInterval(7 * 24 * 60 * 60)//Schedule for data older than a week
        guard now > (lastCleanDate + oneWeek) else { return }
        let request = BGProcessingTaskRequest(
            identifier: cleanHandlerIdentifier
        )
        request.requiresNetworkConnectivity = false
        //Ensures database cleaning runs when user is charging phone and prevents CPU from cancelling the task if the task is performant heavy.
        request.requiresExternalPower = true
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Database cleaning was scheduled")
        } catch {
            print("Could not schedule database cleaning: \(error)")
        }
    }
}
