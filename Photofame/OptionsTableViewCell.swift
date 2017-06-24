//
//  OptionsTableViewCell.swift
//  Photofame
//
//  Created by Appit on 6/24/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit


protocol OptionsTableViewCellProtocol {
    
    func didTapOnDownload()
}

class OptionsTableViewCell: UITableViewCell {

    // Properties
    
    var delegate:OptionsTableViewCellProtocol?
    
    // Outlets
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var favouritesLabel: UILabel!
    @IBOutlet weak var downloadsLabel: UILabel!
    
    // Actions
    
    
    @IBAction func downloadAction(_ sender: UIButton) {
        
        self.delegate?.didTapOnDownload()
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        
        
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
