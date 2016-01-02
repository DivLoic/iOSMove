//
//  BarViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 08/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import Foundation
import CoreMotion
import Darwin
import Charts

class BarViewController: ViewController, ChartViewDelegate{

    // Outlet
    @IBOutlet weak var canvas: BarChartView!

    //var manager : CMMotionManager = CMMotionManager()
    

    let backGround: UIColor = UIColor.whiteColor()

    override func viewDidLoad() {
        super.viewDidLoad()
        initChart()
        canvas.delegate = self
        self.view.backgroundColor = self.backGround
        ViewController.manager.startAccelerometerUpdates()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reDraw(x:Double, y:Double, z:Double) {
        let dataSet = BarChartDataSet(yVals:
            [BarChartDataEntry(value: ceilForDisplay(x), xIndex: 0),
                BarChartDataEntry(value: ceilForDisplay(y), xIndex: 1),
                BarChartDataEntry(value: ceilForDisplay(z), xIndex: 2),
                BarChartDataEntry(value: 1.0, xIndex: 3)], label: "")

        dataSet.colors = [
            UIColor(red:0.04, green:0.40, blue:0.45, alpha:1.0),
            UIColor(red:0.07, green:0.55, blue:0.55, alpha:1.0),
            UIColor(red:0.51, green:0.74, blue:0.67, alpha:1.0),]
        let wraped = BarChartData(xVals: ["X", "Y", "Z"], dataSet: dataSet)
        self.canvas.data = wraped
    }


    func initChart(){
        canvas.setScaleEnabled(false)
        canvas.descriptionText = ""


        //canvas.xAxis.labelFont = UIFont(name: "System 14.0", size: 14)!
        canvas.userInteractionEnabled = false

        canvas.xAxis.labelPosition = .Bottom
        canvas.xAxis.drawGridLinesEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Left).drawAxisLineEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Right).drawAxisLineEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Left).drawLabelsEnabled = false


        //canvas.getAxis(ChartYAxis.AxisDependency.Right).customAxisMax = 1.0
        //canvas.getAxis(ChartYAxis.AxisDependency.Right).customAxisMin = 0.0
        //canvas.getAxis(ChartYAxis.AxisDependency.Right).drawGridLinesEnabled = false

        canvas.gridBackgroundColor = self.backGround
        canvas.backgroundColor = self.backGround
        canvas.animate(xAxisDuration: 0, yAxisDuration: 1.0)
        reDraw(0.1, y: 0.5, z: 0.2)
    }

    override func work() {
        super.work()
        //print("BarChartViewController")
    }
}
