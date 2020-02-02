//
//  String+Extension.swift
//  NAExtensions
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

public extension String {
    
    // to check for valid email
    static func isValidEmail(email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._]+@[A-Za-z0-9]+\\.[A-Za-z]{2,4}")
        return emailTest.evaluate(with: email)
    }
    
    // convert to dictionary
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                return nil
            }
        }
        return nil
    }
}
