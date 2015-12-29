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
    
    private let realm = try! Realm()
    // TODO: OK now leanr how to pass the plist arg to the quit func 
    private static let ksf = "http://ns370799.ip-91-121-193.eu:8083/mobile"
    private static let macidindex = UIDevice.currentDevice()
        .identifierForVendor!.UUIDString.rangeOfString("-")?.startIndex
    private static let id = UIDevice.currentDevice().identifierForVendor!.UUIDString.substringToIndex(macidindex!)
    private static let owner = UIDevice.currentDevice().name
    
    func persite(m: Measure){
        try! self.realm.write {
            var _ = self.realm.add(m)
        }
        
        // TODO: DELETE THIS TEST
        _ = self.realm.objects(Acceleration)
        //print("Their is \(all.count) number of acc")
    }
    
    // Retrieve 5 last measures for line chart
    func last(m: Measure, num: Int){ // -> [Measure]
        if num == 1 {
            //let test = self.realm.objects(Acceleration).sorted("x")
            //print(test)
        }
    }
    
    // TODO: Move this in class measure
    func toJson(m: Measure) -> JSON{
        var dict =  [String: Double]()
        Measure.intro(m, f: {(label: String?, value: Any) -> () in
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
    
    func emit(m: Measure, url: String){
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
    
}
