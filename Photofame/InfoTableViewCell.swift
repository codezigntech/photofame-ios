//
//  InfoTableViewCell.swift
//  Photofame
//
//  Created by Appit on 6/24/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hireMeButton: UIButton!
    
    @IBOutlet weak var infoBackgroundView: UIView!
    @IBOutlet weak var uploadsCountLabel: UILabel!
    
    
    // Actions
    @IBAction func hireMeAction(_ sender: UIButton) {
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
