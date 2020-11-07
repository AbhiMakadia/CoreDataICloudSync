//
//  AppCoordinator.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 03/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: -
    // MARK: - Variables
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: -
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.setupAppearance()
    }
    
    // MARK: -
    // MARK: - Functions
    func setupAppearance() {
        // Customise navigation bar
        navigationController.navigationBar.isHidden = false
        navigationController.navigationBar.tintColor = R.color.orange()
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
    
    func finish() { }
    
    func finishToRootView() { }
    
}// End of Class
