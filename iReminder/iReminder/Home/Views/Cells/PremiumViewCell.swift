//
//  PremiumViewCell.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 10/01/23.
//

import UIKit

class PremiumViewCell: UITableViewCell {
    
    @IBOutlet private weak var contentSuperView: UIView!
    
    //MARK: - Configure Cell UI
    func configureCell() {
        self.selectionStyle = .none
        contentSuperView.dropShadow()
    }
}
