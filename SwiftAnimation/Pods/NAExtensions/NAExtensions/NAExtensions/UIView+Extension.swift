//
//  UIView+Extension.swift
//  NAExtensions
//
//  Created by Nitin A on 21/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

public extension UIView {
    
    // to make view in circle shape
    func makeCircle() {
        layer.cornerRadius = min(frame.size.height, frame.size.width) * 0.5
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    // add multiple views using a single method
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0) }
    }
}

