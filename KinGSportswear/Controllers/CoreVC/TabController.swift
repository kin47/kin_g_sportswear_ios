//
//  TabController.swift
//  KinGSportswear
//
//  Created by MinhTQ4 on 13/06/2024.
//  Copyright © 2024 vinhdd. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        // Do any additional setup after loading the view.
    }
    
    // MARK: tab setup
    private func setupTabs() {
        let home  = createNav(title: "Home", image: UIImage(systemName: "house.fill")!, vc: HomeVC())
        let search  = createNav(title: "Search", image: UIImage(systemName: "magnifyingglass")!, vc: SearchVC())
        let cart  = createNav(title: "Cart", image: UIImage(systemName: "cart.fill")!, vc: CartVC())
        let profile  = createNav(title: "Profile", image: UIImage(systemName: "person.fill")!, vc: ProfileVC())
        self.setViewControllers([home, search, cart, profile], animated: true)
    }
    
    private func createNav(title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
//        nav.navigationItem.title = title
        nav.viewControllers.first?.navigationItem.title = title + " nav"
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
        return nav;
    }
    
    // MARK: - Navigation

}
