//
//  MainSceneDelegate.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 21/04/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.accessibilityIdentifier = "MainWindow"
        let  rootVC = FeedTableViewController()
        let navigationController = UINavigationController(
            rootViewController: rootVC
        )
        if let activity = connectionOptions.userActivities.first ?? session.stateRestorationActivity, activity.activityType == "com.feed.editting" {
            let feedEditVC = FeedEditViewController()
            feedEditVC.restore(from: activity)
            windowScene.userActivity = activity
            windowScene.title = activity.title
            navigationController.pushViewController(feedEditVC, animated: false)
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        print("Restoring scene")
        return scene.userActivity // or window?.rootViewController?.userActivity
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        if let activity = scene.userActivity {
            print("Activity type", activity.activityType)
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        if let userActivity = window?.windowScene?.userActivity {
            userActivity.becomeCurrent()
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        if let userActivity = window?.windowScene?.userActivity {
            userActivity.resignCurrent()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        if let activity = scene.userActivity {
            print("Activity type", activity.activityType)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        if let activity = scene.userActivity {
            print("Activity type", activity.activityType)
        }
    }
}
