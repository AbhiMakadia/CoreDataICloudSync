//
//  PlaceDetailViewModel.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 07/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class PlaceDetailViewModel: NSObject {

    // MARK: - Variables
    var place: Nature = Nature()
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    init(_ obj: Nature) {
        place = obj
    }
    
}
