//
//  ViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 08/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import UIKit
import CoreMotion
class ViewController: UIViewController {

    var confEmission: Bool = false
    var confInterval: Int = 0
    var confHost: String = ""
    var confAxis: String = ""
    
    var clock: Double = 0.0
    var db = MotionPersister()
    var confBundle: NSDictionary = NSDictionary()
    
    static var timer: NSTimer = NSTimer()
    static let manager : CMMotionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshConf()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        ViewController.timer.invalidate()
        ViewController.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
            selector: "work", userInfo: nil, repeats: true)
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

    func work(){
        /** do something **/
        if let datum = ViewController.manager.accelerometerData?.acceleration {
            //reDraw(datum.x, y: datum.y, z: datum.z)
            // TODO: make the barchartViewController reDraw
            if Int(clock) == confInterval {
                db.persite(Acceleration(acc: datum))
                db.emit(Acceleration(acc: datum), url: confHost)
                clock = 0.1
            } else {
                clock += 0.1
            }
        }else{
            
            
        }
    }
}
