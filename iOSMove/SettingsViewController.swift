//
//  SettingsViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 20/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: ViewController, UITextFieldDelegate{
    
    // -- IBOutlet
    
    @IBOutlet var cellCollection: [UIView]!
    @IBOutlet weak var onOff: UISwitch!
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var hostInput: UITextField!
    @IBOutlet weak var segmentAxis: UISegmentedControl!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var drop: UIButton!
    @IBOutlet weak var intervalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hostInput.delegate = self
        self.design()
        self.bindConf()
    }
    
    func bindConf(){
        self.onOff.setOn(confEmission, animated: false)
        self.intervalLabel.text = "\(confInterval)s"
        self.slide.setValue(Float(confInterval), animated: false)
        self.hostInput.text = confHost
        self.segmentAxis.selectedSegmentIndex = ["X","Y","Z"].indexOf(confAxis)!
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    // -- IBAction
    
    @IBAction func switchAction(sender: UISwitch) {
        ViewController.writeBundle(sender.on, key:"emission")
        refreshConf()
    }
    
    @IBAction func slideAction(sender: UISlider) {
        self.intervalLabel.text = "\(Int(sender.value))s"
        ViewController.writeBundle(Int(sender.value), key:"interval")
        refreshConf()
    }
    
    @IBAction func inputAction(sender: UITextField) {
        ViewController.writeBundle(sender.text!, key:"host")
        refreshConf()
    }
    
    @IBAction func segmentAction(sender: UISegmentedControl) {
        ViewController.writeBundle(["X","Y","Z"][sender.selectedSegmentIndex], key: "axis")
    }
    
    @IBAction func reinitialisation(sender: UIButton) {
        let alert = UIAlertController(title: "Reset all",
            message: "Do you really want to reset all the app configuration?",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle(rawValue: 0)!, handler:{ (UIAlertAction) -> () in
            ViewController.writeBundle(true, key:"emission")
            ViewController.writeBundle(4, key:"interval")
            ViewController.writeBundle("http://ns370799.ip-91-121-193.eu:8083/mobile", key:"host")
            ViewController.writeBundle("X", key:"axis")
            self.refreshConf()
            self.bindConf()
            }
            
        ))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle(rawValue: 1)!, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func dropallmeasures(sender: UIButton) {
        let alert = UIAlertController(title: "Drop all records",
            message: "Do you really want to delete all the records on your mobile.You will not able revover theme after this operation.",
            preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle(rawValue: 0)!, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete all", style: UIAlertActionStyle(rawValue: 0)!, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // -- Graphics
    
    func design(){
        for cell in cellCollection{
            cell.layer.borderColor = UIColor(red: 0.871, green: 0.871, blue: 0.871, alpha: 1.00).CGColor
            cell.layer.borderWidth = 0.3;
        }
        onOff.onTintColor = UIColor(red: 0.514, green: 0.741, blue: 0.667, alpha: 1.00)
    }
    
    override func work() {
        super.work()
        //print("SettingViewController")
    }
    
    
}