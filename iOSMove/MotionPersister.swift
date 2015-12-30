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
    

    // TODO: OK now leanr how to pass the plist arg to the quit func 
    private static let ksf = "http://ns370799.ip-91-121-193.eu:8083/mobile"
    private static let macidindex = UIDevice.currentDevice()
        .identifierForVendor!.UUIDString.rangeOfString("-")?.startIndex
    private static let id = UIDevice.currentDevice().identifierForVendor!.UUIDString.substringToIndex(macidindex!)
    private static let owner = UIDevice.currentDevice().name
    
    func persite(m: Object){
        try! AppDelegate.realm.write {
            var _ = AppDelegate.realm.add(m)
        }
        
        // TODO: DELETE THIS TEST
        _ = AppDelegate.realm.objects(Acceleration)
        //print("Their is \(all.count) number of acc")
    }
    
    // Retrieve 5 last measures for line chart
    func last(model: Object.Type, num: Int) -> [Object]{
        let selected = AppDelegate.realm.objects(model).sorted("datetime", ascending: false)
        let slice = selected.dropLast(selected.count - 5)
        return slice.flatMap { (line: Object) -> Object in
            return line
        }
    }
    
    // TODO: Move this in class measure
    func toJson(m: Object) -> JSON{
        var dict =  [String: Double]()
        let mirror = Mirror(reflecting:m)
        mirror.children.forEach({(label: String?, value: Any) -> () in
            let optval = String(value)
            if let key = label {
                let val = Double(optval.substringWithRange(Range<String.Index>(
                    start: optval.startIndex.advancedBy(9),
                    end: optval.endIndex.advancedBy(-1))))
                dict[key] = round(1000*val!)/1000
            }
        })
        return JSON(dict)
    }
    
    func emit(m: Object, url: String){
        var js: JSON = toJson(m)
        js["_id"] = JSON(MotionPersister.id)
        js["owner"] = JSON(MotionPersister.owner)
        js["upsert"] = JSON(true)
        js["time"] = JSON(MotionPersister.now())
        
        Alamofire.request(.POST, url, parameters: ["motion": "\(js)"], encoding: .JSON)
    }
    
    static func quit(){
        // TODO: build a keep score in the Server side
        // TODO: Deleta the propertie ksf
        let js: JSON = JSON("{\"_id\": \"\(MotionPersister.id)\", \"upsert\": false}")
        Alamofire.request(.POST, ksf, parameters: ["motion": "\(js)"], encoding: .JSON)
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
    
}
