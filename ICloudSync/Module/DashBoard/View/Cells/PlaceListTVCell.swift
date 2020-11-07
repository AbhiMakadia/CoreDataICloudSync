//
//  PlaceListTVCell.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 03/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class PlaceListTVCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imgPlace: CustomImageView!
    @IBOutlet weak var lblPlaceName: UILabel!
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func configCell(_ obj: Nature) {
        if let imgData = obj.image {
            imgPlace.image = UIImage(data: imgData)
        }
        lblPlaceName.text = obj.name
    }
    
}
