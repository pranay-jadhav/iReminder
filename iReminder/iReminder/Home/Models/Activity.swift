//
//  Activity.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 11/01/23.
//

import UIKit

enum ActivityType: String {
    case goals = "Goal"
    case routine = "Activity"
}

struct Activity {
    var name: String
    var detials: String
    var date: Date
    var dateString: String
    var activityType: ActivityType
}
