//
//  ViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 08/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var conf: [String: NSObject] = [String: NSObject]()
    var bundle = NSBundle.mainBundle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.conf =  self.bundle.objectForInfoDictionaryKey("UserConfig") as! [String: NSObject]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func makeBundle() -> NSDictionary {
        if let path = NSBundle.mainBundle().pathForResource("/", ofType: "plist"){
            return NSDictionary(contentsOfFile: path)!
        } else {
            return NSDictionary()
        }
    }


}

