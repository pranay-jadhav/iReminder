//
//  LocalNotificationHelper.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 11/01/23.
//

import UIKit

class LocalNotificationHelper {
    
    static let shared = LocalNotificationHelper()
    
    private init() {}
    
    //MARK: - Trigger Local notification
    func triggerNotification(header: String, message: String) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = header
        content.body = message
        content.sound = .default
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(1))
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
}
