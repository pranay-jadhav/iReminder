//
//  GoalsCollectionViewCell.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 10/01/23.
//

import UIKit

class GoalsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var contentSuperView: UIView!
    
    @IBOutlet private weak var acticityCardView: UIView!
    @IBOutlet private weak var createView: UIView!
    
    @IBOutlet private weak var activityNameLbl: UILabel!
    @IBOutlet private weak var activityDesciptionLbl: UILabel!
    @IBOutlet private weak var activityTimeLbl: UILabel!
    
    //MARK: - Configure Cell UI
    func configureCell(data: Activity) {
        contentSuperView.dropShadow()
        
        createView.isHidden = data.name != ""
        activityNameLbl.text = data.name
        activityDesciptionLbl.text = data.detials
        
        let hoursDifference = data.date.hours()
        let minutesDifference = data.date.minutes()
        let timeLeft = data.date.hours() == 0 ? "\(minutesDifference)m" : "\(hoursDifference)h \(minutesDifference - (hoursDifference*60))m"
        self.activityTimeLbl.text = timeLeft
    }
}
