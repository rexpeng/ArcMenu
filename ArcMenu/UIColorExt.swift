//
//  UIColorExt.swift
//  testView
//
//  Created by Rex Peng on 2019/5/24.
//  Copyright © 2019 Rex Peng. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func withInt(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    class func withHex(hex: Int) -> UIColor {
        var alpha = hex & 0xFF000000 >> 64
        if hex < 0x1000000 {
            alpha = 255
        }
        let red   = hex & 0x00FF0000 >> 32
        let green = hex & 0x0000FF00 >> 16
        let blue  = hex & 0x000000FF
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
    }
}
