//
//  LineViewController.swift
//  iOSMove
//
//  Created by Delphine CHANTHAVONG on 15/12/2015.
//  Copyright © 2015 Loïc M. DIVAD. All rights reserved.
//

import Foundation
import Charts

class LineViewController: ViewController,ChartViewDelegate{
    
    @IBOutlet weak var canvas: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let array  = [5.0,0.5,4.0,1.0,10.0]
        drawLineChart(array)
    }
    
    func drawLineChart(p:[Double]){
        var entries: [ChartDataEntry] = []
        for i in 0..<p.count {
            let dataEntry = ChartDataEntry(value: p[i], xIndex: i)
            entries.append(dataEntry)
        }

        let dataSet = LineChartDataSet(yVals: entries, label: "position")
        let data = LineChartData(xVals: p, dataSet: dataSet)
        canvas.data = data
    }
}
