//
//  PhotoStreamViewController.swift
//  RWDevCon
//
//  Created by Mic Pringle on 26/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoStreamViewController: UICollectionViewController {
    
    
    // Properties
    
    
    
    var photos = Photo.allPhotos()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView!.backgroundColor = UIColor.clear
        //    collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        
        
    }
    
    
    func showPhotoDetails(row: Int) {
        
        
        let photo = photos[row]
        
        let photoDetailsTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoDetailsTVC") as! PhotoDetailsTVC
        
        photoDetailsTVC.photo = photo.image
        self.present(photoDetailsTVC, animated: true, completion: nil)
        
    }
    
}

extension PhotoStreamViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotatedPhotoCell", for: indexPath) as! AnnotatedPhotoCell
        cell.photo = photos[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        showPhotoDetails(row: indexPath.row)
    }
    
}

extension PhotoStreamViewController : PinterestLayoutDelegate {
    // 1. Returns the photo height
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        let photo = photos[indexPath.item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: photo.image.size, insideRect: boundingRect)
        return rect.size.height
    }
    
    // 2. Returns the annotation size based on the text
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        
        let photo = photos[indexPath.item]
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let commentHeight = photo.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        return height
    }
    
}

