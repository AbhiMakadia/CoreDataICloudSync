//
//  HomeCoordinator.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 03/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: -
    // MARK: - Variables
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: -
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: -
    // MARK: - Functions
    func start() {
        guard let dashboardVC: DashBoardListVC = R.storyboard.main.dashBoardListVC() else {
            return
        }
        dashboardVC.coordinator = self
        navigationController.viewControllers = [dashboardVC]
    }
    
    func toAddDetailScreen() {
        guard let addDetailScreen: AddDetailVC = R.storyboard.main.addDetailVC() else {
            return
        }
        addDetailScreen.coordinator = self
        navigationController.pushViewController(addDetailScreen, animated: true)
    }
    
    func toDetailScreen(_ obj: Nature) {
        guard let detailScreen: PlaceDetailVC = R.storyboard.main.placeDetailVC() else {
            return
        }
        detailScreen.coordinator = self
        detailScreen.viewModel = PlaceDetailViewModel(obj)
        navigationController.pushViewController(detailScreen, animated: true)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
    
    func finishToRootView() {
    }
    
}
