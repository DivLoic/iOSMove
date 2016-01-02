 //
//  DashboardViewController.swift
//  iOSMove
//
//  Created by Loïc M. DIVAD on 26/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//
//import IOKit
import RealmSwift
import Foundation
import Charts

class DashboardViewController : ViewController{

    // -- IBOutlet
    
    @IBOutlet weak var numberOfRecords: UILabel!
    @IBOutlet weak var lastRec_x: UILabel!
    @IBOutlet weak var lastRec_y: UILabel!
    @IBOutlet weak var lastRec_z: UILabel!
    @IBOutlet weak var lastRec_time: UILabel!
    @IBOutlet weak var batteryLevel: UILabel!
    @IBOutlet weak var canvas: BubbleChartView!
    
    let backGround: UIColor = UIColor.whiteColor()
    //var vcgreen =  UIColor(red: 0.518, green: 0.600, blue: 0.243, alpha: 1.00)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let array1 = [5.0,0.5,4.0]
        let array2 = [2.0,3.5,1.0]
        let array3 = [8.0,5.5,10.0]
        initChart()
        bubleDraw(array1, y: array2, z : array3)
        showRecordsAmount()
        showLastRecord()
        showBatteryLevel()
    }
    
    
    func showRecordsAmount() {
        let selected = AppDelegate.realm.objects(Acceleration.self)
        let recNum = selected.count
        self.numberOfRecords.text = self.numberOfRecords.text! + " " + String(recNum)
    }
    
    func showLastRecord() {
        let records = db.last(Acceleration.self, num: 2)
        records.forEach { (map: Object) -> () in
            let acc = map as! Acceleration
            self.lastRec_x.text = "x : " + String(acc.x)
            self.lastRec_y.text = "y : " + String(acc.y)
            self.lastRec_z.text = "z : " + String(acc.z)
            self.lastRec_time.text = self.lastRec_time.text! + " " + String(acc.datetime) + " - " + String(acc.time)
        }
    }
    
    func showBatteryLevel() {
        //self.batteryLevel.double = IOPCopyPowerSourcesInfo()
    }

    
    func bubleDraw(x:[Double], y:[Double], z:[Double]) {
        
        var entriesBubbleX: [BubbleChartDataEntry] = []
        for i in 0..<x.count {
            let dataEntryBubbleX = BubbleChartDataEntry(xIndex: i, value: 2.0, size: CGFloat(x[i]))
        entriesBubbleX.append(dataEntryBubbleX)
        }
        
        var entriesBubbleY: [BubbleChartDataEntry] = []
        for i in 0..<y.count {
            let dataEntryBubbleY = BubbleChartDataEntry(xIndex: i, value: 4.0, size: CGFloat(y[i]))
            entriesBubbleY.append(dataEntryBubbleY)
        }
        
        var entriesBubbleZ: [BubbleChartDataEntry] = []
        for i in 0..<z.count {
            let dataEntryBubbleZ = BubbleChartDataEntry(xIndex: i, value: 6.0, size: CGFloat(z[i]))
            entriesBubbleZ.append(dataEntryBubbleZ)
        }

        let entriesBubble = entriesBubbleX + entriesBubbleY + entriesBubbleZ
        
        let dataSetBubble = BubbleChartDataSet(yVals: entriesBubble, label :"")
        let wrapedBubble = BubbleChartData(xVals: x + y + z, dataSet: dataSetBubble)
        canvas.data = wrapedBubble
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

    }

    
    override func work() {
        super.work()
  
    }
    

}