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
    
    
    // TODO: Fill properties and mathods
    func ping(){}
    
    static func intro(m: Measure, f: () -> ()){
        let mirror = Mirror(reflecting:m)
        mirror.children.forEach { (label: String?, value: Any) -> () in
        
        }
        
    }
    
    
}