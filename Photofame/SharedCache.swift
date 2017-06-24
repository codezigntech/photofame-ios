//
//  SharedCache.swift
//  Photofame
//
//  Created by Appit on 6/25/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class SharedCache: NSObject {
    
    static let shared: SharedCache = SharedCache()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private override init() {
        super.init()
        
        
    }
    

}
