//
//  LineViewController.swift
//  iOSMove
//
//  Created by Delphine CHANTHAVONG on 15/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import Foundation
import Charts
import RealmSwift

class LineViewController: ViewController, ChartViewDelegate{
    
    @IBOutlet weak var canvas: LineChartView!
    let backGround: UIColor = UIColor.whiteColor()
    var vcgreen =  UIColor(red: 0.518, green: 0.600, blue: 0.243, alpha: 1.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.delegate = self
        setChart()
    }
    
    func drawLineChart(p:[Double]){
        var entries: [ChartDataEntry] = []
        for i in 0..<p.count {
            let dataEntry = ChartDataEntry(value: p[i], xIndex: i)
            entries.append(dataEntry)
        }

        let dataSet = LineChartDataSet(yVals: entries, label: "position \(confAxis)")
        dataSet.colors = [vcgreen]
        dataSet.circleColors = [vcgreen]
        let data = LineChartData(xVals: p, dataSet: dataSet)
        canvas.data = data
    }
    
    func setChart(){
        canvas.setScaleEnabled(false)
        canvas.userInteractionEnabled = false
        
        canvas.xAxis.labelPosition = .Bottom
        canvas.xAxis.drawGridLinesEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Left).drawAxisLineEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Right).drawAxisLineEnabled = false
        canvas.getAxis(ChartYAxis.AxisDependency.Left).drawLabelsEnabled = false

        canvas.gridBackgroundColor = self.backGround
        canvas.backgroundColor = self.backGround
        
        printValues()
    }
    
    override func work() {
        super.work()
        if Int(self.clock) == confInterval {
            printValues()
        }
    }
    
    func printValues(){
        var axis: [Double] = []
        
        let records = db.last(Acceleration.self, num: 5).reverse()
        records.forEach { (r: Object) -> () in
            let acc = r as! Acceleration
            if (confAxis == "X"){
                axis.append(acc.x)
            }else if (confAxis == "Y"){
                axis.append(acc.y)
            }else if (confAxis == "Z"){
                axis.append(acc.z)
            }
        }
        drawLineChart(axis)
    }
}
