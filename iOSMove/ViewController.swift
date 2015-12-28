//
//  ViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 08/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static var timer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        ViewController.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "probe", userInfo: nil, repeats: true)
    }

    func probe(){
        /** do something **/
    }
}
