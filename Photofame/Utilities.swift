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
    
}
