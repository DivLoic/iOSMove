//
//  ViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 08/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var conf: NSDictionary = NSDictionary()
    var bundle = NSBundle.mainBundle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.conf = ViewController.makeBundle()//self.bundle.objectForInfoDictionaryKey("UserConfig") as! [String: NSObject]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func makeBundle() -> NSDictionary {
        var dico = NSDictionary()
        if let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist"){
            dico = NSDictionary(contentsOfFile: path)!
        }
        return dico
    }
    
    static func writeBundle(value: AnyObject ,key: String){
        var dico = NSMutableDictionary()
        if let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist"){
            dico = NSMutableDictionary(contentsOfFile: path)!
            dico.setObject(value, forKey: key)
            dico.writeToFile(path, atomically: false)
        }
    }


}

