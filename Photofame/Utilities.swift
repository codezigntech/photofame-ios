//
//  Utilities.swift
//  Photofame
//
//  Created by Appit on 6/24/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    
    class func getRatio(width:CGFloat, height: CGFloat, newWidth: CGFloat) -> (CGFloat) {
        return (height / width) * newWidth
    }
    
    
    class func getImage(fromURL urlString:String, name: String?, completion: @escaping (_ image: UIImage?, _ success: Bool, _ name: String?) -> Void) {
        
        let imageCache = SharedCache.shared.imageCache
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage, true, name)
        } else {
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                
                if error == nil {
                    guard let image = UIImage(data: data!)
                        else { return }
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        imageCache.setObject(image, forKey: urlString as NSString)
                        completion(image, true, name)
                    })
                } else {
                    completion(nil, false, name)
                }
                
            }).resume()
        }
    }
    
        
 
    class func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) == 6) {
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if ((cString.characters.count) == 8) {
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x000000FF) / 255.0,
                alpha: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            )
        }else{
            return UIColor.gray
        }
    }
    
}

