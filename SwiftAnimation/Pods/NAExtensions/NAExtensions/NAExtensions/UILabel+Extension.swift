//
//  UILabel+Extension.swift
//  NAExtensions
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

public extension UILabel {
    
    // add spacing between each character in label
    func addCharacterSpacing(kernValue: Double = 3) {
        if let labelText = text, labelText.isEmpty == false {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
