//
//  AddEventViewController.swift
//  LinkUp
//
//  Created by Del Shawn Kirksey on 8/22/17.
//  Copyright © 2017 Del Shawn Kirksey. All rights reserved.
//

import UIKit
import Foundation
import CoreFoundation
import FirebaseDatabase

class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var eventDateField: UITextField!
    
    let eventTypeData = [String](arrayLiteral: "Get lunch", "Play basketball", "Get food", "Get drinks", "Dance", "Run", "See a movie", "Shop", "Custom")
    var eventDateData = [String](arrayLiteral: "Today")
    
    let eventTypePicker = UIPickerView()
    let eventDatePicker = UIPickerView()
    
    //var ref: DatabaseReference!
    let ref = Database.database().reference(withPath: "events")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eventTypeTextField.inputView = eventTypePicker
        eventTypePicker.delegate = self
        
        eventDateData.append(contentsOf: ["Tomorrow, " + getTomorrowsDate(), getTheNextDay()])
        eventDateField.inputView = eventDatePicker
        eventDatePicker.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == eventTypePicker {
            return eventTypeData.count
        } else {
            return eventDateData.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == eventTypePicker {
            return eventTypeData[row]
        } else {
            return eventDateData[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == eventTypePicker {
            if eventTypeData[row] == "Custom" {
                eventTypeTextField.inputView = nil
                eventTypeTextField.reloadInputViews()
            } else {
                eventTypeTextField.text = eventTypeData[row]
                self.view.endEditing(true)
            }
        } else {
            eventDateField.text = eventDateData[row]
            self.view.endEditing(true)
        }
    }
    
    func getTomorrowsDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date().tomorrow)
    }
    
    func getTheNextDay() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date().theNextDay)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Clear Event", message: "Are you sure you want to leave before creating the event?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { (alert: UIAlertAction!) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
            //print("You pressed Cancel")
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)
        
        
    }
}

extension Date {
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var theNextDay: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: self)!
    }
}
