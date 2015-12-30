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
        let dataSet = BarChartDataSet(yVals:[
            BarChartDataEntry(value: ceilForDisplay(x), xIndex: 0),
            BarChartDataEntry(value: ceilForDisplay(y), xIndex: 1),
            BarChartDataEntry(value: ceilForDisplay(z), xIndex: 2),
            BarChartDataEntry(value: 1.0, xIndex: 3)], label: "")

        dataSet.colors = [
            UIColor(red: 0.996, green: 0.969, blue: 0.776, alpha: 1.00),
            UIColor(red: 0.518, green: 0.600, blue: 0.243, alpha: 1.00),
            UIColor(red: 0.741, green: 0.796, blue: 0.541, alpha: 1.00)]
        let wraped = BarChartData(xVals: ["X", "Y", "Z"], dataSet: dataSet)
        self.canvas.data = wraped
    }


    func initChart(){
        canvas.setScaleEnabled(false)
        canvas.descriptionText = ""
        canvas.userInteractionEnabled = false

        canvas.xAxis.labelPosition = .Bottom
        canvas.xAxis.drawGridLinesEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Left).drawAxisLineEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Right).drawAxisLineEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Left).drawLabelsEnabled = false

        canvas.gridBackgroundColor = self.backGround
        canvas.backgroundColor = self.backGround
        canvas.animate(xAxisDuration: 0, yAxisDuration: 1.0)
        reDraw(0.1, y: 0.5, z: 0.2)
    }

    func ceilForDisplay(figures: Double) -> Double{
        return abs(round(100*figures)/100)
    }

    override func work() {
        super.work()
        if let datum = ViewController.manager.accelerometerData?.acceleration {
            reDraw(datum.x, y: datum.y, z: datum.z)
        }
    }
}
