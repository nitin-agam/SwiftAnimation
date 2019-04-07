//
//  Extensions.swift
//  SwiftAnimation
//
//  Created by Nitin A on 07/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    static let kBackground = UIColor.rgb(r: 21, g: 22, b: 33)
    static let kOutlineStroke = UIColor.rgb(r: 234, g: 46, b: 111)
    static let kTrackStroke = UIColor.rgb(r: 56, g: 25, b: 49)
    static let kPulsingFill = UIColor.rgb(r: 86, g: 30, b: 63)
}
