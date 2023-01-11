//
//  HomeTableHeaders.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 10/01/23.
//

import UIKit

class HomeTableHeaders: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var headerTitle: UILabel!
    
    //MARK: - Configure Header UI
    func configureHeader(title: String) {
        headerTitle.text = title
    }
}
