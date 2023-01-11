//
//  SuperViewController.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 11/01/23.
//

import UIKit

class SuperViewController: UIViewController {

    private var screenYPosition = 0.0 //Tracks screen Y position
    private var isScreenYpositionSetted = false //Checks if "screenYPosition" value is setted only once
    var toolBar : UIToolbar?
    
    //MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpKeyboardUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //MARK: - Keyboard actions
    private func setUpKeyboardUI(){
       
        //Adding toolbar above keyboard
        self.toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let DoneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: target,
                                         action: #selector(tapDone))
        self.toolBar?.setItems([flexibleSpace, DoneButton], animated: false)
        
    }
    
    
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        if !self.isScreenYpositionSetted{
            self.isScreenYpositionSetted = true
            self.screenYPosition = self.view.frame.origin.y
        }
        
        if let activeTextField = UIResponder.currentFirst() as? UITextField {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                let activeTextFieldFrame = activeTextField.convert(self.view.frame, to: self.view)
                let calculatedY = self.view.frame.maxY - activeTextFieldFrame.minY - activeTextField.frame.height
                if (calculatedY) < keyboardHeight {
                    if self.view.frame.origin.y == self.screenYPosition {
                        self.view.frame.origin.y -= (keyboardHeight - calculatedY + 50) // here 50 is the toolbar height
                    }
                }
            }
        }
    }

    @objc func keyboardWillDisappear() {
        if view.frame.origin.y != self.screenYPosition {
            self.view.frame.origin.y = self.screenYPosition
        }
    }
    
    //Toolbar done button action
    @objc func tapDone() {
       self.view.endEditing(true)
     }
    
}
