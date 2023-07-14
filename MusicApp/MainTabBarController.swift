//
//  MainTabBarController.swift
//  MusicApp
//
//  Created by Артем Гаршин on 14.07.2023.
//

import UIKit


class MainTabBarController: UITabBarController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617023, alpha: 1)
        
        
        
        
        viewControllers = [     //свойство для передачи контроллеров в TabBar
            generateViewController(rootViewController: SearchViewController(), image: #imageLiteral(resourceName: "search"), title: "Search"),
            generateViewController(rootViewController: ViewController(), image: #imageLiteral(resourceName: "library"), title: "Library")
        ]
    }
    
    
    //MARK: -функция для передачи наших view
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController{
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
        
    }
}
