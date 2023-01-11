//
//  ActivityCell.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 10/01/23.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    @IBOutlet private weak var contentSuperView: UIView!
    @IBOutlet private weak var createView: UIView!
    
    @IBOutlet private weak var activityCardView: UIView!
    @IBOutlet private weak var activityNameLbl: UILabel!
    @IBOutlet private weak var activityDescriptionLbl: UILabel!
    @IBOutlet private weak var activityTimrLbl: UILabel!
    
    //MARK: - Configure Cell UI
    func configureCell(data: Activity) {
        createView.isHidden = data.name != ""
        self.selectionStyle = .none
        contentSuperView.dropShadow()
        activityNameLbl.text = data.name
        activityDescriptionLbl.text = data.detials
        
        let hoursDifference = data.date.hours()
        let minutesDifference = data.date.minutes()
        let timeLeft = data.date.hours() == 0 ? "\(minutesDifference)m" : "\(hoursDifference)h \(minutesDifference - (hoursDifference*60))m"
        self.activityTimrLbl.text = timeLeft
    }
}
