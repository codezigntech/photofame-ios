//
//  UploadPhotoCell.swift
//  Photofame
//
//  Created by Appit on 6/25/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class UploadPhotoCell: UITableViewCell {
    
    
    // Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: FlowLayout!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
