//
//  Container.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 02/01/2016.
//  Copyright © 2016 Loïc M. DIVAD. All rights reserved.
//

import UIKit
import Foundation

extension UITabBarController {
    
    public override func shouldAutorotate() -> Bool {
        if let selected = selectedViewController {
            if(selected.isKindOfClass(DashboardViewController)){
                if(UIDevice.currentDevice().orientation.isLandscape){
                    return false
                } else {
                    return true
                }
            } else {
                return true
            }
        } else {
            return super.shouldAutorotate()
        }
    }
}
