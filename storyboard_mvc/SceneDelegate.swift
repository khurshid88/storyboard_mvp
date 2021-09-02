//
//  SceneDelegate.swift
//  storyboard_mvc
//
//  Created by User on 2021/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        callHomeController()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    func callHomeController(){
        let vc = HomeViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.isTranslucent = false
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }

}

