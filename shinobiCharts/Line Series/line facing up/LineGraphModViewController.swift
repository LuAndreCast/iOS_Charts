//
//  ViewController.swift
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class LineGraphModViewController: UIViewController,SChartDelegate
{
    //properties
    @IBOutlet weak var chartView: UIView!
    private var chart:ShinobiChart?
    private let chartDataSource = LineGraphModDataSource()
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        chart = ShinobiChart(frame: chartView.bounds)
        chartView.addSubview(chart!)
        
        self.setupChart()
    }//eom
    
    func setupChart()
    {
        chart?.delegate = self
        chart?.licenseKey =  Constants.shared.getLicenseKey()
        chart?.title             = "Line Facing up"
        chart?.autoresizingMask  = [.flexibleHeight , .flexibleWidth]
        chart?.datasource = chartDataSource
        
        /* X axis - Dates */
        let dateRange:SChartDateRange = chartDataSource.getInititalDateRange()
        chart?.xAxis = SChartDateTimeAxis()
        chart?.xAxis.range = dateRange
        chart?.xAxis.axisPosition = SChartAxisPositionNormal
        chart?.xAxis.title = "Dates"
        chart?.xAxis.labelFormatString = "MM dd"
        chart?.xAxis.majorTickFrequency = SChartDateFrequency.dateFrequency(withDay: 2)
//        chart?.xAxis.minorTickFrequency = SChartDateFrequency.dateFrequency(withDay: 1)
        
        //style
        chart?.xAxis.style.majorGridLineStyle.showMajorGridLines = true
        chart?.xAxis.style.majorTickStyle.showTicks = true
        chart?.xAxis.style.majorTickStyle.showLabels = true
        chart?.xAxis.style.minorTickStyle.showTicks = false
        chart?.xAxis.style.minorTickStyle.showLabels = false
        
        //axis movement
//        chart?.xAxis.enableGesturePanning = true
//        chart?.xAxis.enableGestureZooming = true
//        chart?.xAxis.enableMomentumPanning = true
//        chart?.xAxis.enableMomentumZooming = true
        
        /* Y axis - Values */
        chart?.yAxis = SChartNumberAxis()
        chart?.yAxis.defaultRange = SChartRange(minimum: 0, andMaximum: 10)
        chart?.yAxis.title = "Y axis"
        chart?.yAxis.axisPosition = SChartAxisPositionReverse
        chart?.yAxis.majorTickFrequency = 1
        chart?.yAxis.minorTickFrequency = 1
        chart?.yAxis.rangePaddingLow = 1
        chart?.yAxis.rangePaddingHigh = 1
        
        
        //style
        chart?.yAxis.style.majorGridLineStyle.showMajorGridLines = true
        chart?.yAxis.style.majorTickStyle.showTicks = true
        chart?.yAxis.style.majorTickStyle.showLabels = true
        chart?.yAxis.style.minorTickStyle.showTicks = false
        chart?.yAxis.style.minorTickStyle.showLabels = false
        
        //axis movement
//        chart?.yAxis.enableGesturePanning = true
//        chart?.yAxis.enableGestureZooming = true
//        chart?.yAxis.enableMomentumPanning = true
//        chart?.yAxis.enableMomentumZooming = true
    }//eom
    
    
    
    func setupLegend()
    {
        chart?.legend.isHidden = false
        chart?.legend.position = SChartLegendPosition.bottomMiddle
        chart?.legend.style.orientation = SChartLegendOrientation.horizontal
        chart?.legend.style.horizontalPadding = 10
        chart?.legend.style.symbolAlignment = SChartSeriesLegendSymbolAlignment.alignSymbolsLeft
        chart?.legend.style.textAlignment = NSTextAlignment.left
    }//eom
    
}//eoc

