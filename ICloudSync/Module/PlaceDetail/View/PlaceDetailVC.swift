//
//  PlaceDetailVC.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 07/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class PlaceDetailVC: UIViewController {

    // MARK: - Variables
    var coordinator: HomeCoordinator?
    var viewModel: PlaceDetailViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgPlace: CustomImageView!
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var lblPlaceAddress: UILabel!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Functions
    func setupUI() {
        if let imgData = viewModel.place.image {
            imgBackground.image = UIImage(data: imgData)
            imgPlace.image = UIImage(data: imgData)
        }
        lblPlaceName.text = viewModel.place.name
        lblPlaceAddress.text = viewModel.place.address
    }
    
}
