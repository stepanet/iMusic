//
//  MainTabBarController.swift
//  iMusic
//
//  Created by Пятин Дмитрий on 18.07.2020.
//  Copyright © 2020 Пятин Дмитрий. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        viewControllers = [
            generateViewController(rootViewController: SearchViewController(), image: #imageLiteral(resourceName: "search"), title: "Search"),
            generateViewController(rootViewController: ViewController(), image: #imageLiteral(resourceName: "Library"), title: "Lirary")
        ]
        
    }
    
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}
