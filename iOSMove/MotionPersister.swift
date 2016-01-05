//
//  MotionPersister.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 12/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import UIKit
import Darwin
import Charts
import Alamofire
import Foundation
import RealmSwift
import SwiftyJSON

class MotionPersister {

    func persite(m: Object){
        try! AppDelegate.realm.write {
            var _ = AppDelegate.realm.add(m)
        }
    }
    
    // Retrieve 5 last measures for line chart
    func last(model: Object.Type, num: Int) -> [Object]{
        let selected = AppDelegate.realm.objects(model).sorted("datetime", ascending: false)
        if selected.count <= num{
            return [Object]()
        } else {
            let slice = selected.dropLast(selected.count - num)
            return slice.flatMap { (line: Object) -> Object in
                return line
            }
        }
    }
    
    func toJson(m: Object) -> JSON{
        var dict =  [String: String]()
        let mirror = Mirror(reflecting:m)
        mirror.children.forEach({(label: String?, value: Any) -> () in
            let optval = String(value)
            if let key = label {
                if ["x","y","z"].contains(key){
                    dict[key] = "\((round(100*Double(optval)!)/100))"
                } else {
                    dict[key] = optval
                }
            }
        })
        return JSON(dict)
    }
    
    func emit(m: Object, url: String){
        var js: JSON = toJson(m)
        js["_id"] = JSON(MotionPersister.getDeviceId())
        js["owner"] = JSON(UIDevice.currentDevice().name)
        js["upsert"] = JSON(true)
        
        Alamofire.request(.POST, url, parameters: ["motion": "\(js)"], encoding: .JSON)
    }
    
    static func quit(){
        let url = ViewController.mainBundle()["host"] as! String
        let js: JSON = JSON("{\"_id\": \"\(MotionPersister.getDeviceId())\", \"upsert\": false}")
        Alamofire.request(.POST, url, parameters: ["motion": "\(js)"], encoding: .JSON)
    }
    
    static func now() -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss";
        return formatter.stringFromDate(NSDate())
    }
    
    static func today() -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH:mm:ss";
        return formatter.stringFromDate(NSDate())
    }
    
    static func getDeviceId() -> String {
        let macidindex = UIDevice.currentDevice()
            .identifierForVendor!.UUIDString
            .rangeOfString("-")?.startIndex
        
        return UIDevice.currentDevice().identifierForVendor!
            .UUIDString.substringToIndex(macidindex!)
    }
    
}
