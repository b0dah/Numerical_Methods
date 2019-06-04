//
//  ViewController.swift
//  Adams
//
//  Created by Иван Романов on 28/05/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import UIKit
import Charts

func f826(x: Double, y: [Double]) -> [Double] {
    return [ y[1] + 2*exp(x),
             y[0] + x * x,
             0]
}

func s826(x: Double/*, y: [Double]*/) -> [Double] {
    return [ exp(x) + 2*exp( -x) + x*exp(x) - x*x-2,
             exp(x) - 2*exp( -x) + (x-1) * exp(x)-2*x ]
}

func f827(x: Double, y: [Double]) -> [Double] {
    return [ y[1] - 5*cos(x),
             2*y[0] + y[1] ]
}

func s827(x: Double) -> [Double] {
    return [ exp(-x) + exp( 2*x) - cos(x) - 2*sin(x),
             -exp(-x) + 2 * exp( 2*x) + 3*cos(x) + sin(x) ]
}

func f835(x: Double, y: [Double]) -> [Double] {
    return [ 2*y[0] - 4 * y[1],
             y[0] - 3 * y[1] + 3 * exp(x),
             0]
}

func s835(x: Double/*, y: [Double]*/) -> [Double] {
    return [ 4/Double(3) * exp(x) - 4/Double(3) * exp( -2 * x) - 4 * x * exp(x),
             1/Double(3) * exp(x) - 4/Double(3) * exp( -2 * x) - (x-1) * exp(x),
             0 ]
}


var EXAMPLE = 1

class ViewController: UIViewController {

    @IBOutlet weak var firstChartView: LineChartView!
    
    @IBOutlet weak var secondChartView: LineChartView!
    
    @IBAction func drawChartButton(_ sender: UIButton) {
        EXAMPLE += 1
        drawCharts()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawCharts()
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
    
    func drawCharts() {
        
        var example1 = Adams(f: f826, a: 0, b: 1, y0: [1,-2], solution: s826, size: 2)
        
        switch EXAMPLE {
        case 1:
            example1 = Adams(f: f826, a: 0, b: 1, y0: [1,-2], solution: s826, size: 2)
        case 2:
            example1 = Adams(f: f835, a: 0, b: 1, y0: [0.0,0.0], solution: s835, size: 2)
        default:
            example1 = Adams(f: f827, a: 0, b: 2, y0: [1,4], solution: s827, size: 2)
        }
        
        
        firstChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        var dataEntry = [ChartDataEntry](), solutionDataEntry = [ChartDataEntry]()
        
        for i in 0..<example1.N {
            let point = ChartDataEntry(x: example1.argValues[i], y: example1.resultValues[i][0])
            let solutionPoint = ChartDataEntry(x: example1.argValues[i], y: example1.solutionValues[i][0])
            
            dataEntry.append(point)
            solutionDataEntry.append(solutionPoint)
        }
        
        let line = LineChartDataSet(values: dataEntry, label: "Computed")
        line.colors = [UIColor.blue]
        line.circleRadius = 8
        
        let solutionLine = LineChartDataSet(values: solutionDataEntry, label: "Precise")
        solutionLine.colors = [UIColor.orange]
        solutionLine.circleRadius = 4
        solutionLine.circleColors = [UIColor.orange]
        
        let data = LineChartData(dataSets: [line, solutionLine])
        self.firstChartView.data = data
        
         //// 2nd ///////// -- ---------------------------------------------------
        
        secondChartView.animate(xAxisDuration: 1.0, yAxisDuration: 2.0)
        
        
        dataEntry = [ChartDataEntry]()
        solutionDataEntry = [ChartDataEntry]()
        
        for i in 0..<example1.N {
            let point = ChartDataEntry(x: example1.argValues[i], y: example1.resultValues[i][1])
            let solutionPoint = ChartDataEntry(x: example1.argValues[i], y: example1.solutionValues[i][1])
            
            dataEntry.append(point)
            solutionDataEntry.append(solutionPoint)
        }
        
        let secondLine = LineChartDataSet(values: dataEntry, label: "Computed")
        secondLine.colors = [UIColor.blue]
        secondLine.circleRadius = 8
        
        let secondSolutionLine = LineChartDataSet(values: solutionDataEntry, label: "Precise")
        secondSolutionLine.colors = [UIColor.orange]
        secondSolutionLine.circleRadius = 4
        secondSolutionLine.circleColors = [UIColor.orange]
        
        let secondData = LineChartData(dataSets: [secondLine, secondSolutionLine])
        self.secondChartView.data = secondData
    }
  
    
    

}

