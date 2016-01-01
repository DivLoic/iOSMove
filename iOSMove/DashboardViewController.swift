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

class DashboardViewController : ViewController{



    @IBOutlet weak var canvas: BubbleChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let array1 = [5.0,0.5,4.0]
        let array2 = [2.0,3.5,6.0]
        let array3 = [8.0,5.5,10.0]
        initChart()
        bubleDraw(array1, y: array2, z : array3)
    
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
        let wrapedBubble = BubbleChartData(xVals: x, dataSet: dataSetBubble)
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