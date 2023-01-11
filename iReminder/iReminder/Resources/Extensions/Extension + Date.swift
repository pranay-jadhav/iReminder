//
//  Extension + Date.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 11/01/23.
//

import Foundation

extension Date {
    
    func formattedDateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
    func hours() -> Int {
        return Calendar.current.dateComponents([.hour], from: Date(), to: self).hour ?? 0
    }
    
    func minutes() -> Int {
        return Calendar.current.dateComponents([.minute], from: Date(), to: self).minute ?? 0
    }
}
