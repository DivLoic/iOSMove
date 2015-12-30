//
//  Acceleration.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 12/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import Foundation
import RealmSwift

class Acceleration: Object{
    
    dynamic var x = 0.0
    dynamic var y = 0.0
    dynamic var z = 0.0
    
    dynamic var time = "00:00:00"
    dynamic var datetime = ""
    
    func setting(x: Double,y: Double, z:Double){
        self.x = x
        self.y = y
        self.z = z
        self.time = MotionPersister.now()
        self.datetime = MotionPersister.today()
    }
    
}