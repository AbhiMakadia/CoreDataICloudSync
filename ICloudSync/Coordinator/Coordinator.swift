//
//  Coordinator.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 03/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

/// Coordinator to manage the flow this method are requird to implement in every coordinator
protocol Coordinator: AnyObject {

    func start()
    func finish()
    func finishToRootView()
}
