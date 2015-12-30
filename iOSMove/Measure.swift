//
//  Measure.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 12/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Measure: Object{
    
    var date: NSDate? = nil
    
    func measure(){
        date = NSDate()
    }
    
    // TODO: Use the power of heritage by writing non static
    
    static func intro(m: Measure, f: (label: String?, value: Any) -> ()){
        let mirror = Mirror(reflecting:m)
        mirror.children.forEach(f)
    }
    
    static func map(m: Measure, f: (label: String?, value: Any) -> ()) -> [Dictionary<String,Any>]{
        var mapping: [Dictionary<String,Any>] = []
        let mirror = Mirror(reflecting:m)
        for child in mirror.children.enumerate(){
            mapping.append([child.element.label!: child.element.value])
        }
        return mapping
    }
    
    
}