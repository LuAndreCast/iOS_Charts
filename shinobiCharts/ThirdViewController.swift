//
//  ThirdViewController.swift
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController , SChartDelegate
{
    var chart:ShinobiChart = ShinobiChart(frame: CGRectMake(0, 0, 0, 0))
    let dataSource:TornadoDataSource = TornadoDataSource()
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //chart data
        dataSource.base = 50
        
        //chart
        let margin = (UIDevice.currentDevice().userInterfaceIdiom == .Phone ) ? CGFloat(10) : CGFloat(50)
        
        /* take into consideration Navigation Bar */
        var viewBounds:CGRect = view.bounds
        if let navBarHeight:CGFloat = self.navigationController?.navigationBar.frame.size.height
        {
            let calcY:CGFloat = ( navBarHeight + CGFloat.init(20))
            let calcHeight = viewBounds.height - calcY
            
            viewBounds = CGRectMake(0, calcY , viewBounds.width, calcHeight)
        }
        
        chart = ShinobiChart( frame: CGRectInset(viewBounds, margin, margin) )
        chart.licenseKey = shinobiTrialLicenseKey
        
        chart.autoresizingMask = [ .FlexibleHeight , .FlexibleWidth ]
        
        chart.datasource = dataSource
        
        self.view.addSubview(chart)
        
        
        //axis
        let xAxis   = SChartNumberAxis()
        xAxis.enableGesturePanning = true
        xAxis.enableGestureZooming = true
        xAxis.enableMomentumPanning = true
        xAxis.enableMomentumZooming = true
        xAxis.axisPosition = SChartAxisPositionReverse
        chart.xAxis = xAxis
        
        let yAxis   = SChartCategoryAxis()
        chart.yAxis = yAxis
        
        
        let baseAnnotation:SChartAnnotation = SChartAnnotation .verticalLineAtPosition(50,
                                                                  withXAxis: chart.xAxis,
                                                                  andYAxis: chart.yAxis,
                                                                  withWidth: 2.0,
                                                                  withColor: chart.plotAreaBorderColor)
        
        
        
        
        chart.addAnnotation(baseAnnotation)
        
        let range:SChartNumberRange = SChartNumberRange(minimum: 0, andMaximum: 100)
        chart.xAxis.defaultRange = range
        
        
    }

}
