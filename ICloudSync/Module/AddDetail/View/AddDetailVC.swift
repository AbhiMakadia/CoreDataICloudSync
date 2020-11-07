//
//  AddDetailVC.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 03/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class AddDetailVC: UIViewController {

    // MARK: - Variables
    var coordinator: HomeCoordinator?
    
    // MARK: - Outlets
    @IBOutlet weak var tfPlaceName: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var imgPlace: CustomImageView!
    @IBOutlet weak var imgbackground: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IB Action
    @IBAction func btnSaveAction(_ sender: CustomButton) {
        CoreDataAccess.shared.insertPlaces(image: imgPlace.image, place: tfPlaceName.text, address: tfAddress.text) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.coordinator?.finish()
        }
    }
    
    @IBAction func btnAddPlaceImageAction(_ sender: UIButton) {
        ImagePickerManager().pickImage(self, sourceView: self.view, showRemovePhoto: false, { [weak self] (image) in
            guard let `self` = self else {
                return
            }
            self.imgbackground.image = image
            self.imgPlace.image = image
            
        }) { (_) in
        }
    }
    
}
