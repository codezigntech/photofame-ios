//
//  PhotoDetailsTVC.swift
//  Photofame
//
//  Created by Appit on 6/24/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class PhotoDetailsTVC: UIViewController {

    
    
    // MARK: - Properties
    var tags = [Tag]()
    
    var photo: UIImage?
    
    let TAGS = ["Tech", "Design", "Humor", "Travel", "Music", "Writing", "Social Media", "Life", "Education", "Edtech", "Education Reform", "Photography", "Startup", "Poetry", "Women In Tech", "Female Founders", "Business", "Fiction", "Love", "Food", "Sports"]
    
    var sizingCell: TagCell?
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // Initial configuration
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.closeButton.layer.masksToBounds = true
        self.closeButton.layer.cornerRadius = self.closeButton.frame.height / 2.0
        
        
        // tableview Automatic height
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        // data
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    
    func configureCollectionView(tabCell: TagsTableViewCell) {
        
        let cellNib = UINib(nibName: "TagCell", bundle: nil)
        tabCell.collectionView.register(cellNib, forCellWithReuseIdentifier: "TagCell")
        tabCell.collectionView.backgroundColor = UIColor.clear
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCell?
        tabCell.flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        for name in TAGS {
            let tag = Tag()
            tag.name = name
            self.tags.append(tag)
        }
    }
    

}

extension PhotoDetailsTVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as! PhotoTableViewCell
            photoCell.photoImageView.image = self.photo
            
            return photoCell
        } else if indexPath.row == 1 {
            let optionsCell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCell") as! OptionsTableViewCell
            
            
            return optionsCell
        } else if indexPath.row == 2 {
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as! InfoTableViewCell
            infoCell.infoBackgroundView.layer.cornerRadius = 4.0
            
            infoCell.profileImageView.layer.masksToBounds = true
            infoCell.profileImageView.layer.cornerRadius = infoCell.profileImageView.frame.width / 2.0
            
            infoCell.hireMeButton.layer.masksToBounds = true
            infoCell.hireMeButton.layer.cornerRadius = infoCell.hireMeButton.frame.height / 2.0
            
            
            return infoCell
        } else if indexPath.row == 3 {
            let tabsCell = tableView.dequeueReusableCell(withIdentifier: "TagsTableViewCell") as! TagsTableViewCell
            
            tabsCell.collectionView.dataSource = self
            tabsCell.collectionView.delegate = self
            
            self.configureCollectionView(tabCell: tabsCell)
            
            return tabsCell
        }

        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            if let photo = self.photo {
                
                if photo.size.width > self.view.frame.width {
                    let height = Utilities.getRatio(width: photo.size.width,
                                                    height: photo.size.height,
                                                    newWidth: self.view.frame.width)
                    
                    return height
                }
            }
        }
        
        return UITableViewAutomaticDimension
        
    }
    

    
}

extension PhotoDetailsTVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        self.configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.configureCell(self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: false)
//        tags[indexPath.row].selected = !tags[indexPath.row].selected
//        self.collectionView.reloadData()
//    }
    
    func configureCell(_ cell: TagCell, forIndexPath indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        cell.tagName.text = tag.name
//        cell.tagName.textColor = tag.selected ? UIColor.white : UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
//        cell.backgroundColor = tag.selected ? UIColor(red: 0, green: 1, blue: 0, alpha: 1) : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
    
    
}

















