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
        print("🔌 Connecting MainScene")
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootVC = FeedTableViewController()
        window.rootViewController = UINavigationController(
            rootViewController: rootVC
        )
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("🌇 MainScene will enter foreground")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("🌇 MainScene became active")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("🌇 MainScene will resign active")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("🌆 MainScene entered background")
        // Example: trigger scene session activation
        if let userActivity = scene.session.stateRestorationActivity ?? scene.userActivity {
            UIApplication.shared.requestSceneSessionActivation(
                nil,
                userActivity: userActivity,
                options: nil,
                errorHandler: { error in
                    print("⚠️ Failed to activate MainScene: \(error)")
                }
            )
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("🌇 MainScene did disconnect")
    }
}
