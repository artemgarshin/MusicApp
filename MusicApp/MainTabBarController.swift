//
//  MainTabBarController.swift
//  MusicApp
//
//  
//

import UIKit
import SwiftUI

protocol MainTabBarControllerDelegate: class{
    func minimizedTrackDetailController()
    func maximizedTrackDetailController(viewModel: SearchViewModel.Cell?)
}


class MainTabBarController: UITabBarController{
    
    
    
    
    var minimizedtopAnchorConstraint: NSLayoutConstraint!
    var maximizedTopAnchoreConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTrackDetailView()
        view.backgroundColor = .gray
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617023, alpha: 1)
        
        searchVC.tabBarDelegate = self
        
        let library = Library()
        let hostVC = UIHostingController(rootView: library)
        hostVC.tabBarItem.image = #imageLiteral(resourceName: "library")
        hostVC.tabBarItem.title = "Library"
        
        
        
        
        viewControllers = [     //свойство для передачи контроллеров в TabBar
            hostVC,
            generateViewController(rootViewController: searchVC, image: #imageLiteral(resourceName: "search"), title: "Search")
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
    

    //MARK: SetupDetailView
    private func setUpTrackDetailView(){
        print("тут мы будем настраивать трек дитеил вью ")
        
        trackDetailView.backgroundColor = .white
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        // use auto layout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAnchoreConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedtopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        
        bottomAnchorConstraint.isActive = true
        maximizedTopAnchoreConstraint.isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
    }
}


//MARK: Max and min animation func
extension MainTabBarController: MainTabBarControllerDelegate{
    func maximizedTrackDetailController(viewModel: SearchViewModel.Cell?) {
        
        minimizedtopAnchorConstraint.isActive = false
        maximizedTopAnchoreConstraint.isActive = true
        maximizedTopAnchoreConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
            self.trackDetailView.miniTrackView.alpha = 0
            self.trackDetailView.maximizedStackView.alpha = 1
            
        },
                       completion: nil)
        
        guard let viewModel = viewModel else {return}
        self.trackDetailView.set(viewModel: viewModel)
        
    }
    
    func minimizedTrackDetailController() {
        maximizedTopAnchoreConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedtopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 1
            self.trackDetailView.miniTrackView.alpha = 1
            self.trackDetailView.maximizedStackView.alpha = 0

            
        },
                       completion: nil)
    }
    
    
}
