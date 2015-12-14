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
    // TODO: That'a awfull, learn how to use a plist file
    private static let ksf = "http://ns370799.ip-91-121-193.eu:8083/mobile"
    private static let id = UIDevice.currentDevice().identifierForVendor!.UUIDString
    
    
    func persite(m: Measure){
        try! self.realm.write {
            var _ = self.realm.add(m)
            
        }
        
        // TODO: DELETE THIS TEST
        let all = self.realm.objects(Acceleration)
        print("Their is \(all.count) number of acc")
        
    }
    
    // TODO: Move this in class measure
    func toJson(m: Measure) -> JSON{
        var dict =  [String: Double]()
        let mirror = Mirror(reflecting:m)
        mirror.children.forEach { (label: String?, value: Any) -> () in
            let optval = String(value)
            if let key = label {
                let v = Double(optval.substringWithRange(Range<String.Index>(
                        start: optval.startIndex.advancedBy(9),
                        end: optval.endIndex.advancedBy(-1))))
                dict[key] = round(1000*v!)/1000

            }
        }
        return JSON(dict)
    }
    
    
    func emit(m: Measure){
        var js: JSON = toJson(m)
        print(MotionPersister.id)
        js["_id"] = JSON(MotionPersister.id)
        js["upsert"] = JSON(true)
        js["time"] = JSON(MotionPersister.now())
        // TODO: learn how to deal with time in swift
        
        Alamofire.request(.POST, MotionPersister.ksf, parameters: ["motion": "\(js)"], encoding: .JSON)
    
    }
    
    static func quit(){
        let js: JSON = JSON("{\"\(MotionPersister.id)\": 1, \"upsert\": false}")
        Alamofire.request(.POST, MotionPersister.ksf, parameters: ["motion": "\(js)"], encoding: .JSON)
    }
    
    static func now() -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss";
        return formatter.stringFromDate(NSDate())
    }
    
}
