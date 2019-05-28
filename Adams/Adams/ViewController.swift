//
//  ViewController.swift
//  Adams
//
//  Created by Иван Романов on 28/05/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var firstChartView: LineChartView!
    
    @IBAction func drawChartButton(_ sender: UIButton) {
        setChartValues()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChartValues()
    }
    
    
    
    
    func setChartValues() {
        
        firstChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        let numberOfPoints = 100
        var x_coord = 0.0
        
        var DataEntry = [ChartDataEntry]()
        
        for i in 0..<numberOfPoints {
            let point = ChartDataEntry(x: Double(x_coord), y: Double(0.2))
            x_coord += 0.01
            
            DataEntry.append(point)
        }
        
        let set1 = LineChartDataSet(values: DataEntry, label: "Computed")
        set1.colors = [UIColor.blue]
        //set1.circleColors = [UIColor.blue]
        set1.circleRadius = 6
 
        //////////////////////////////////////////
        x_coord = 0.0
        var DataEntry2 = [ChartDataEntry]()
        
        for i in 0..<numberOfPoints {
            let point = ChartDataEntry(x: Double(x_coord), y: Double(0.2))
            x_coord += 0.01
            
            DataEntry2.append(point)
        }
        
        let set2 = LineChartDataSet(values: DataEntry2, label: "Precise")
        set2.circleRadius = 4
        set2.colors = [UIColor.orange]
        
         set2.circleColors = [UIColor.orange]
        /////////////////////////////////////////
        
        let data = LineChartData(dataSets: [set1, set2])
        
        self.firstChartView.data = data
        
    }


}

