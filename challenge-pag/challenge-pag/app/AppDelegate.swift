//
//  AppDelegate.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Vars
    var window: UIWindow?
    
    //MARK: - Lets
    let homeName = "Main"
    let homeIdentifier = "home"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setNavigationBar()
        self.configureInitialViewController()

        return true
    }

    private func setNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.systemBlue
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .highlighted)
    }
    
    private func configureInitialViewController() {
        window = UIWindow()

        /* Create ui-view-controller instance*/
        let home = HomeRouter.createModule()

        /* Initiating instance of ui-navigation-controller with view-controller */
        let navigationController = UINavigationController(rootViewController: home)

        /* Setting up the root view-controller as ui-navigation-controller */
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        
        
//        let storyboard = UIStoryboard(name: homeName, bundle: nil)
//        let startViewController = storyboard.instantiateViewController(withIdentifier: homeIdentifier)
//
//        window?.rootViewController = startViewController
//        window?.makeKeyAndVisible()
    }
}

