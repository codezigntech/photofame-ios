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
    
    var dashboardViewController: DashboardVC!
//    var isLoadingImages: Bool = false
    
    
    
//    var photos = Photo.allPhotos()
    var photos = [Photo]()
    
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
        
        collectionView?.register(UINib(nibName: "LoadMore", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "LoadMore")

        if let collectionViewFlowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            
            // Use collectionViewFlowLayout
            collectionViewFlowLayout.headerReferenceSize = CGSize(width: self.collectionView!.frame.size.width, height: 80)
        }
        
        loadImages()
    }
    
    
    func showPhotoDetails(row: Int) {
        
        let photo = photos[row]
        
        let photoDetailsTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoDetailsTVC") as! PhotoDetailsTVC
        
        photoDetailsTVC.photo = photo.image
        photoDetailsTVC.photoObject = photo
        
        self.present(photoDetailsTVC, animated: true, completion: nil)
    }
    
    func loadImages() {
        
        let offset = "\(photos.count)"
        
        self.photos = [Photo]()
//        self.collectionView?.reloadData()
        
//        self.isLoadingImages = true
        NetworkManager.getMediaService(forOffset: offset) { (result) in
            print("loading images.....")
            if let result = result {
                
                for item in result {
                    
                    if let item = item as? [String: Any] {
                        
                        let photo = Photo(dictionary: NSDictionary())
                        photo.id = item["id"] as? Int
                        photo.width = item["width"] as? Int
                        photo.height = item["height"] as? Int
                        photo.file = item["file"] as? String
                        photo.backgroundColorHexa = item["background_colour"] as? String
                        
                        
                        self.photos.append(photo)
                        
                    }
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
//                self.isLoadingImages = false
            }
        }
    }
    
    
}

extension PhotoStreamViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photos.count)
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotatedPhotoCell", for: indexPath) as! AnnotatedPhotoCell
        
        // download image and show
        let photo = photos[indexPath.item]

        let color = Utilities.hexStringToUIColor(hex: photo.backgroundColorHexa!)
            
            DispatchQueue.main.async {
                cell.myBackgroudView.backgroundColor = color
            }

        
        if photo.image == nil {
            
            let urlString = "http://dw89cy0du3h7h.cloudfront.net/\(photo.file!)"
            
            Utilities.getImage(fromURL: urlString, name: nil) { (image, success, name) in
                
                DispatchQueue.main.async {
                    photo.image = image
                    cell.imageView.image = image
                }
            }
            
        } else {
            
            DispatchQueue.main.async {
                cell.imageView.image = photo.image
            }
        }
        
        
//        cell.photo = photos[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        showPhotoDetails(row: indexPath.row)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "LoadMore", for: indexPath as IndexPath)
        // configure footer view
        return view
        
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let threshold: CGFloat = 100
//        let contentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        if (maximumOffset - contentOffset <= threshold) && (maximumOffset - contentOffset != -5.0) {            //Add ten more rows and reload the table content.
//            
//            
//            
//            dashboardViewController.showLoadMore()
//            
//            if isLoadingImages == false {
//                print("load more...")
//                loadImages()
//            }
//            
//        } else {
//            print("load more no no")
//            dashboardViewController.hideLoadMore()
//        }
//    }
   
    
}

extension PhotoStreamViewController : PinterestLayoutDelegate {
    // 1. Returns the photo height
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        let photo = photos[indexPath.item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        
        let size = CGSize(width: photo.width!, height: photo.height!)
        
        let rect  = AVMakeRect(aspectRatio: size, insideRect: boundingRect)
        return rect.size.height
    }
    
    // 2. Returns the annotation size based on the text
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        
        let photo = photos[indexPath.item]
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
      //  let commentHeight = photo.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + annotationPadding
        return height
    }
    
}


