 //
//  DashboardViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 26/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//


import RealmSwift
import Foundation
import Charts
import UIKit
 
class DashboardViewController : ViewController, ChartViewDelegate{

    // -- IBOutlet
    
    @IBOutlet weak var numberOfRecords: UILabel!
    @IBOutlet weak var lastRec_x: UILabel!
    @IBOutlet weak var lastRec_y: UILabel!
    @IBOutlet weak var lastRec_z: UILabel!
    @IBOutlet weak var lastRec_time: UILabel!
    @IBOutlet weak var batteryLevel: UILabel!
    @IBOutlet weak var batteryState: UILabel!
    @IBOutlet weak var canvas: BubbleChartView!
    
    let device = UIDevice.currentDevice()
    
    let backGround: UIColor = UIColor.whiteColor()
    var vcgreen =  UIColor(red: 0.518, green: 0.600, blue: 0.243, alpha: 1.00)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfRecords.textColor = vcgreen
        device.batteryMonitoringEnabled = true
        initChart()
        bubleDraw()
        displayRecordsCount()
        displayBattery()
    }
    
    // display the total count of Acc
    func displayRecordsCount() {
        numberOfRecords.text = "\(AppDelegate.realm.objects(Acceleration.self).count)"
    }
    
    // display 3 axis for the last record
    func displayLastRecord(a: Acceleration) {
        lastRec_x.text = "Last x: \(ceilForDisplay(a.x))"
        lastRec_y.text = "Last y: \(ceilForDisplay(a.y))"
        lastRec_z.text = "Last z: \(ceilForDisplay(a.z))"
        lastRec_time.text = "Time : \(a.time)"
    }
    
    // display the battery lvl & state
    func displayBattery() {
        batteryLevel.text = "Battery lvl: \(self.device.batteryLevel * 100)%"
        batteryState.text = "State: \(stateOfBattery())"
    }

    
    func bubleDraw() {
        
        var allX = [Double]()
        var tableX = [BubbleChartDataEntry]()
        var tableY = [BubbleChartDataEntry]()
        var tableZ = [BubbleChartDataEntry]()
        let lastAcc = db.last(Acceleration.self, num: 7).reverse()
        
        for(idx, obj) in lastAcc.enumerate(){
            if let acc = obj as? Acceleration{
                tableX.append(BubbleChartDataEntry(xIndex: idx, value: 1.0, size: CGFloat(ceilForDisplay(acc.x))))
                tableY.append(BubbleChartDataEntry(xIndex: idx, value: 3.0, size: CGFloat(ceilForDisplay(acc.y))))
                tableZ.append(BubbleChartDataEntry(xIndex: idx, value: 5.0, size: CGFloat(ceilForDisplay(acc.z))))
                allX.append(Double(idx))
            }
        }
        
        let dataSetX = BubbleChartDataSet(yVals: tableX, label :"X")
        let dataSetY = BubbleChartDataSet(yVals: tableY, label :"Y")
        let dataSetZ = BubbleChartDataSet(yVals: tableZ, label :"Z")
        
        dataSetX.setColor(UIColor(red: 0.996, green: 0.969, blue: 0.776, alpha: 0.70))
        dataSetY.setColor(UIColor(red: 0.518, green: 0.600, blue: 0.243, alpha: 0.70))
        dataSetZ.setColor(UIColor(red: 0.741, green: 0.796, blue: 0.541, alpha: 0.70))
        
        let wrapedBubble = BubbleChartData(xVals: allX)
        wrapedBubble.addDataSet(dataSetX)
        wrapedBubble.addDataSet(dataSetY)
        wrapedBubble.addDataSet(dataSetZ)

        canvas.data = wrapedBubble
    }
    
    func initChart(){
        canvas.setScaleEnabled(false)
        canvas.descriptionText = ""
        
        canvas.userInteractionEnabled = false
        
        canvas.xAxis.labelPosition = .Bottom
        canvas.xAxis.drawGridLinesEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Right).drawGridLinesEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Left).drawAxisLineEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Right).drawAxisLineEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Left).drawLabelsEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Right).drawLabelsEnabled = false
        
        canvas.gridBackgroundColor = self.backGround
        canvas.backgroundColor = self.backGround

    }
    
    // Funtion return the state of the battery:
    // See: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIDevice_Class/#//apple_ref/c/tdef/UIDeviceBatteryState
    func stateOfBattery() -> String{
        switch device.batteryState {
        case .Unknown:
            // cannot be determined
            return "Unknown"
        case .Unplugged:
            // the battery is discharging
            return "Unplugged"
        case .Charging:
            // device is plugged
            return "Charging"
        case .Full:
            // 100% charged
            return "Full"
        }
    }
    
    override func work() {
        super.work()
        if Int(clock) == confInterval{
            displayRecordsCount()
            displayBattery()
            bubleDraw()
            let acc = AppDelegate.realm.objects(Acceleration).last
            if let a = acc{
                displayLastRecord(a)
            }
        }
    }

}