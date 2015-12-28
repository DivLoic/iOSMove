//
//  ViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 08/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var confEmission: Bool = false
    var confInterval: Int = 0
    var confHost: String = ""
    var confAxis: String = ""

    var confBundle: NSDictionary = NSDictionary()
    
    static var timer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshConf()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshConf(){
        self.confBundle = ViewController.loadBundle()
        confEmission = self.confBundle["emission"] as! Bool
        confInterval = self.confBundle["interval"] as! Int
        confHost = self.confBundle["host"] as! String
        confAxis = self.confBundle["axis"] as! String
    }

    static func mainBundle()-> NSDictionary{
        var dico = NSDictionary()
        if let path = NSBundle.mainBundle().pathForResource("user", ofType: "plist"){
            dico = NSDictionary(contentsOfFile: path)!
        }
        return dico
    }

    static func loadBundle() -> NSDictionary {
        let bundle = fileConfigPath()
        if(NSFileManager.defaultManager().fileExistsAtPath(bundle)){
            return NSDictionary(contentsOfFile: bundle)!
        } else {
            if let mainpath = NSBundle.mainBundle().pathForResource("user", ofType: "plist"){
                do{ try NSFileManager.defaultManager().copyItemAtPath(mainpath, toPath: bundle)
                } catch { }
            }
            return mainBundle()
        }
    }

    static func writeBundle(value: AnyObject, key: String){
        var dico = NSMutableDictionary()
        let bundle = fileConfigPath()
        if(NSFileManager.defaultManager().fileExistsAtPath(bundle)){
            dico = NSMutableDictionary(contentsOfFile: bundle)!
            dico.setObject(value, forKey: key)
            dico.writeToFile(bundle, atomically: true)
        }
    }

    static func fileConfigPath() -> String{
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let url = NSURL(string: path)
        let bundle = url!.URLByAppendingPathComponent("user.plist").absoluteString
        return bundle
    }

    override func viewDidAppear(animated: Bool) {
        ViewController.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "probe", userInfo: nil, repeats: true)
    }

    func probe(){
        /** do something **/
    }
}
