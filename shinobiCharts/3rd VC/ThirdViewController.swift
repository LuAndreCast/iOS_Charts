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
    var chart:ShinobiChart = ShinobiChart(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let dataSource:TornadoDataSource = TornadoDataSource()
    
    var baseAnnotation:SChartAnnotation = SChartAnnotation()
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //chart data
        dataSource.base = 50
        
        //chart
        let margin = (UIDevice.current.userInterfaceIdiom == .phone ) ? CGFloat(10) : CGFloat(50)
        
        /* take into consideration Navigation Bar */
        var viewBounds:CGRect = view.bounds
        if let navBarHeight:CGFloat = self.navigationController?.navigationBar.frame.size.height
        {
            let calcY:CGFloat = ( navBarHeight + CGFloat.init(20))
            let calcHeight = viewBounds.height - calcY
            
            viewBounds = CGRect(x: 0, y: calcY , width: viewBounds.width, height: calcHeight)
        }
        
        chart = ShinobiChart( frame: viewBounds.insetBy(dx: margin, dy: margin) )
        chart.licenseKey = Constants.shared.getLicenseKey()
        
        chart.autoresizingMask = [ .flexibleHeight , .flexibleWidth ]
        
        chart.datasource = dataSource
        
        self.view.addSubview(chart)
        
        
        //axis
        let xAxis   = SChartNumberAxis()
        xAxis?.enableGesturePanning = true
        xAxis?.enableGestureZooming = true
        xAxis?.enableMomentumPanning = true
        xAxis?.enableMomentumZooming = true
        xAxis?.axisPosition = SChartAxisPositionReverse
        chart.xAxis = xAxis
        
        let yAxis   = SChartCategoryAxis()
        chart.yAxis = yAxis
        
        //adding annotation
        self.baseAnnotation = SChartAnnotation .verticalLine(atPosition: 50,
                                                                  withXAxis: chart.xAxis,
                                                                  andYAxis: chart.yAxis,
                                                                  withWidth: 2.0,
                                                                  with: chart.plotAreaBorderColor)
        
        
        
        
        self.chart.add(self.baseAnnotation)
        
        // Set the default range on the chart so the data is visible (This is necessary otherwise there would be no
        // space on the right hand side of the tornado bars.
        let range:SChartNumberRange = SChartNumberRange(minimum: 0, andMaximum: 100)
        chart.xAxis.defaultRange = range
        
        
    }

}
