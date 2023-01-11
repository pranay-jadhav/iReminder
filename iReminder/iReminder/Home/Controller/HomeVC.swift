//
//  ViewController.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 10/01/23.
//

import UIKit

class HomeVC: SuperViewController,
              UITableViewDelegate,
              UITableViewDataSource ,
              GoalsCollectionCellDelegate{

    @IBOutlet private weak var homeTableView: UITableView!
    @IBOutlet private weak var createPopupView: UIView!
    
    @IBOutlet private weak var activityNameHeader: UILabel!
    @IBOutlet private weak var activityNameTF: UITextField!
    @IBOutlet private weak var activityNameError: UILabel!
    
    @IBOutlet private weak var activityDescriptionHeader: UILabel!
    @IBOutlet private weak var activityDesciptionTF: UITextField!
    
    @IBOutlet private weak var activityDateTF: UITextField!
    @IBOutlet private weak var activityDatePicker: UIDatePicker!
    @IBOutlet private weak var activityDateError: UILabel!
    
    @IBOutlet private weak var createButtonOutlet: UIButton!
    
    private var currentActivityType: ActivityType = .goals
    
    private var goalsDataSource = [Activity]()
    private var activitiesDataSource = [Activity]()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        
        //Headers
        let homeTableHeaders = UINib(nibName: "HomeTableHeaders", bundle: nil)
        homeTableView.register(homeTableHeaders, forHeaderFooterViewReuseIdentifier: "HomeTableHeaders")
        
        //Cells
        let premiumCell = UINib(nibName: "PremiumViewCell", bundle: nil)
        homeTableView.register(premiumCell,
                               forCellReuseIdentifier: "PremiumViewCell")
        
        let goalsCollectionCell = UINib(nibName: "GoalsCollectionCell", bundle: nil)
        homeTableView.register(goalsCollectionCell,
                               forCellReuseIdentifier: "GoalsCollectionCell")
        
        let activityCell = UINib(nibName: "ActivityCell", bundle: nil)
        homeTableView.register(activityCell,
                               forCellReuseIdentifier: "ActivityCell")
        
        self.activityNameTF.inputAccessoryView = self.toolBar
        self.activityDesciptionTF.inputAccessoryView = self.toolBar
        
        timer = Timer.scheduledTimer(timeInterval: 60.0,
                                             target: self,
                                             selector: #selector(scheduleChecker),
                                             userInfo: nil,
                                             repeats: true)
        
        self.activityDatePicker.minimumDate = Date()
        
        //Create empty cell at end
        let emptyGoal = Activity(name: "",
                                 detials: "",
                                 date: Date(),
                                 dateString: "",
                                 activityType: .goals)
        goalsDataSource.append(emptyGoal)
        activitiesDataSource.append(emptyGoal)
        
    }
    
    //MARK: - Activity Validators and Generate Activities
    private func validateFields() -> Bool {
        let name = self.activityNameTF.text ?? ""
        let dateString = self.activityDatePicker.date.formattedDateTimeString()
        
        if name == "" || dateString == "" {
            self.activityNameError.isHidden = name != ""
            self.activityDateError.isHidden = dateString != ""
            return false
        } else {
            return true
        }
    }

    private func generateActivity() {
        let name = self.activityNameTF.text ?? ""
        let description = self.activityDesciptionTF.text ?? ""
        let date = self.activityDatePicker.date
        let dateString = self.activityDatePicker.date.formattedDateTimeString()
        
        let activity = Activity(name: name,
                                detials: description,
                                date: date,
                                dateString: dateString,
                                activityType: self.currentActivityType)
        
        if self.currentActivityType == .goals {
            self.goalsDataSource.insert(activity, at: 0)
        } else {
            self.activitiesDataSource.insert(activity, at: 0)
        }
        self.createPopupView.isHidden = true
        self.homeTableView.reloadData()
    }
    
    private func showCreatePopup(type: ActivityType) {
        self.activityNameTF.text = ""
        self.activityDesciptionTF.text = ""
        self.activityNameError.isHidden = true
        self.activityDateError.isHidden = true
        
        self.activityDateTF.text = Date().formattedDateTimeString()
        
        self.currentActivityType = type
        self.createPopupView.isHidden = false
        self.activityNameHeader.text = type.rawValue + " Name"
        self.activityDescriptionHeader.text = type.rawValue + " Description"
        self.createButtonOutlet.setTitle("Create \(type.rawValue)", for: .normal)
    }
    
    //MARK: - IBAction
    @IBAction func datePickerAction(_ sender: Any) {
        self.view.endEditing(true)
        self.activityDateTF.text = self.activityDatePicker.date.formattedDateTimeString()
    }
    
    @IBAction func createActivity(_ sender: Any) {
        self.view.endEditing(true)
        if validateFields() {
            generateActivity()
        }
    }
    
    @IBAction func removePopup(_ sender: Any) {
        self.view.endEditing(true)
        self.createPopupView.isHidden = true
    }
    
    //MARK: - TableView Delegates ans Datasources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return self.activitiesDataSource.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let premiumCell = tableView.dequeueReusableCell(withIdentifier: "PremiumViewCell", for: indexPath) as! PremiumViewCell
            premiumCell.configureCell()
            return premiumCell
            
        case 1:
            let goalsCollectionCell = tableView.dequeueReusableCell(withIdentifier: "GoalsCollectionCell", for: indexPath) as! GoalsCollectionCell
            goalsCollectionCell.delegate = self
            goalsCollectionCell.configureCell(data: goalsDataSource, indexPath: indexPath)
            return goalsCollectionCell
            
        case 2:
            let activityCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
            activityCell.configureCell(data: activitiesDataSource[indexPath.row])
            return activityCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 115
        case 1:
            return 200
        case 2:
            return 160
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableHeaders") as! HomeTableHeaders
        
        switch section {
        case 0:
            return UIView()
        case 1:
            headerView.configureHeader(title: "Must Do For Your Goals")
            return headerView
            
        case 2:
            headerView.configureHeader(title: "Activity Routine")
            return headerView
            
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 0.0001
        case 1:
            return 30
        case 2:
            return 30
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if activitiesDataSource[indexPath.row].name == "" {
                showCreatePopup(type: .routine)
            }
        }
    }
    func createNewGoal(indexPath: IndexPath) {
        if goalsDataSource[indexPath.row].name == "" {
            showCreatePopup(type: .goals)
        }
    }
    
    //MARK: - Notofication Helper
    @objc func scheduleChecker() {
        self.goalsDataSource.forEach { eachGoal in
            checkNotifications(eachGoal: eachGoal)
        }
        self.activitiesDataSource.forEach { eachGoal in
            checkNotifications(eachGoal: eachGoal)
        }
    }
    
    private func checkNotifications(eachGoal: Activity) {
        let hours = eachGoal.date.hours()
        let minutes = eachGoal.date.minutes()
        if hours == 0 && minutes < 2 {
            if eachGoal.name != "" {
                //Trigger notification
                let header = "Get Ready for \(eachGoal.name)."
                let message = "Your \(eachGoal.activityType.rawValue) is scheduled in a minute"
                LocalNotificationHelper.shared.triggerNotification(header: header, message: message)
            }
        }
    }
}

