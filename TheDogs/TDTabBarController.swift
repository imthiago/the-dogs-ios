//
//  TDTabBarController.swift
//  TheDogs
//
//  Created by Thiago Oliveira on 07/12/21.
//

import UIKit

class TDTabBarController: UITabBarController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor         = .systemOrange
        UITabBar.appearance().backgroundColor   = .systemBackground
        viewControllers = [createBreedListNavigationController(), createSearchBreedNavigationController()]
    }

    // MARK: - Private methods

    private func createBreedListNavigationController() -> UINavigationController {
        let breedListViewController         = BreedListViewController()
        breedListViewController.title       = "Breeds"
        breedListViewController.tabBarItem  = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)

        return UINavigationController(rootViewController: breedListViewController)
    }

    private func createSearchBreedNavigationController() -> UINavigationController {
        let searchBreedViewController           = SearchBreedViewController()
        searchBreedViewController.title         = "Search"
        searchBreedViewController.tabBarItem    = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        return UINavigationController(rootViewController: searchBreedViewController)
    }
}
