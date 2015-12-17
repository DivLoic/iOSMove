//
//  Acceleration.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 12/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import Foundation
import CoreMotion

class Acceleration: Measure{
    
    var x: Double? = nil
    var y: Double? = nil
    var z: Double? = nil
    
    
    init(d:[Double]){
        self.x = d[0]
        self.y = d[1]
        self.z = d[2]
        super.init()
    }
    
    convenience init(acc: CMAcceleration){
        self.init(d: [acc.x, acc.y, acc.z])
    }
    
    convenience required init() {
        self.init(d: [0.0, 0.0, 0.0])
    }
    
}