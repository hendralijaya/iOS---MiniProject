//
//  AppDelegate.swift
//  MiniProject
//
//  Created by hendra on 02/12/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: MenuListCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        navController.navigationItem.backButtonTitle = ""
        
        // Initialize the Coordinator with the navigation controller
        let menuListCoordinator = MenuListCoordinator(navigationController: navController)
        self.coordinator = menuListCoordinator
        
        // Set the rootViewController to the navigation controller
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
        
        // Call the Coordinator to start the flow
        menuListCoordinator.route()
        
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
}

