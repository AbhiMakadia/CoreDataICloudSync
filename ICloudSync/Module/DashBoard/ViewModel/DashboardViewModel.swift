//
//  DashboardViewModel.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 07/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class DashboardViewModel: NSObject {

    // MARK: - Variable Declarations
    var arrPlaces: [Nature] = []
    //closure
    var reloadData: (() -> Void)?
    
    // MARK: - Initializers
    override init() {
        super.init()
        refreshPlaces()
        DispatchQueue.delay(bySeconds: 7.0) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.refreshPlaces()
        }
    }
    
    // MARK: - Functions
    @objc func refreshPlaces() {
        self.arrPlaces = CoreDataAccess.shared.getAllPlaces() ?? [Nature]()
        reloadData?()
    }
    
    @objc func check() {
        print("refresh content --->", CoreDataAccess.shared.getAllPlaces()?.count ?? 0)
    }
}
