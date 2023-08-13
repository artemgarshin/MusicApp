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
            generateViewController(rootViewController: SearchMusicViewController(), image: #imageLiteral(resourceName: "search"), title: "Search"),
            generateViewController(rootViewController: ViewController(), image: #imageLiteral(resourceName: "library"), title: "Library")
        ]
        let separatorView = UIView()
        separatorView.backgroundColor = .gray // Настройте цвет разделителя
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(separatorView, at: 1) // Отображаем разделитель перед первой вкладкой
        
        // Настраиваем констрейнты для разделителя
        // Устанавливаем меньшее значение высоты для разделителя (например, 0.5)
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
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
