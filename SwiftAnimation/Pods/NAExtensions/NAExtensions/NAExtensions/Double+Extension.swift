//
//  Double+Extension.swift
//  NAExtensions
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

public extension Double {
    
    // convert the timestamp (in double type) into String format with proper display time. Basically this method used to show time on chat screen. i.e. last active user time
    func convertDate() -> String {
        var string = ""
        let date = Date(timeIntervalSince1970: self)
        let calendar = Calendar.current
        let formatter = DateFormatter()
        if calendar.isDateInToday(date) {
            string = ""
            formatter.timeStyle = .short
        } else if calendar.isDateInYesterday(date) {
            string = "yesterday: "
            formatter.timeStyle = .short
        } else {
            formatter.timeStyle = .short
        }
        let dateString = formatter.string(from: date)
        return string + dateString
    }
}
