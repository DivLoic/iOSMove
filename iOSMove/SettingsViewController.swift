//
//  SettingsViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 20/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: ViewController{
    
    @IBOutlet var cellCollection: [UIView]!
    @IBOutlet weak var onOff: UISwitch!
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var hostInput: UITextField!
    @IBOutlet weak var segmentAxis: UISegmentedControl!
    
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var drop: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.design()
    }
    
    
    func design(){
        for cell in cellCollection{
            cell.layer.borderColor = UIColor(red: 0.871, green: 0.871, blue: 0.871, alpha: 1.00).CGColor
            cell.layer.borderWidth = 0.3;
        }
        onOff.onTintColor = UIColor(red: 0.514, green: 0.741, blue: 0.667, alpha: 1.00)
    }
}