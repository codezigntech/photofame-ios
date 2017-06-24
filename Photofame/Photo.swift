//
//  Photo.swift
//  RWDevCon
//
//  Created by Mic Pringle on 04/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class Photo {
    
    class func allPhotos() -> [Photo] {
        var photos = [Photo]()
        if let URL = Bundle.main.url(forResource: "Photos", withExtension: "plist") {
            if let photosFromPlist = NSArray(contentsOf: URL) {
                for dictionary in photosFromPlist {
                    let photo = Photo(dictionary: dictionary as! NSDictionary)
                    photos.append(photo)
                }
            }
        }
        return photos
    }
    
    var image: UIImage?
    
    var file: String?
    var width: Int?
    var height: Int?
    var id: Int?
    
    var backgroundColorHexa: String?
    
//    init(caption: String, comment: String, image: UIImage) {
//        self.caption = caption
//        self.comment = comment
//        self.image = image
//    }
    
    init(dictionary: NSDictionary) {
        let caption = dictionary["Caption"] as? String
        let comment = dictionary["Comment"] as? String
        let photo = dictionary["Photo"] as? String
        
        if let photo = photo {
            let image = UIImage(named: photo)?.decompressedImage
//            self.init(caption: caption!, comment: comment!, image: image!)
        }
        
    }
    
//    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
//        let rect = NSString(string: comment).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
//        return ceil(rect.height)
//    }
    
}
