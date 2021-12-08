//
//  SceneDelegate.swift
//  TheDogs
//
//  Created by Thiago Oliveira on 07/12/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = TDTabBarController()
        window?.makeKeyAndVisible()

        configureNavigationBar()
    }

    private func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemOrange
    }
}
