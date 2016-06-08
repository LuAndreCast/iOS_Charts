//
//  SecondViewController.swift
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, SChartDatasource
{
    //MARK: -   View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let margin = (UIDevice.currentDevice().userInterfaceIdiom == .Phone ) ? CGFloat(10) : CGFloat(50)
        
        /* take into consideration Navigation Bar */
        var viewBounds:CGRect = view.bounds
        if let navBarHeight:CGFloat = self.navigationController?.navigationBar.frame.size.height
        {
            let calcY:CGFloat = ( navBarHeight + CGFloat.init(20))
            let calcHeight = viewBounds.height - calcY
            
            viewBounds = CGRectMake(0, calcY , viewBounds.width, calcHeight)
        }
        let chart = ShinobiChart( frame: CGRectInset(viewBounds, margin, margin) )

        chart.licenseKey        = shinobiTrialLicenseKey
        chart.title             = "Simple Chart #2"
        chart.autoresizingMask  =  [.FlexibleHeight , .FlexibleWidth]
        chart.datasource        = self

        let xAxis   = SChartNumberAxis()
        xAxis.title = "X Value"
        xAxis.enableGesturePanning = true
        xAxis.enableGestureZooming = true
        chart.xAxis = xAxis

        let yAxis   = SChartNumberAxis()
        yAxis.title = "Y Value"
        yAxis.enableGesturePanning = true
        yAxis.enableGestureZooming = true
        yAxis.rangePaddingLow   = 0.1
        yAxis.rangePaddingHigh  = 0.1
        chart.yAxis = yAxis
        
        //shows legend on ipad only
        chart.legend.hidden = UIDevice.currentDevice().userInterfaceIdiom == .Phone

        
        view.addSubview(chart)
    }//eom


    //MARK: - Chart Datasource
    func numberOfSeriesInSChart(chart: ShinobiChart!) -> Int {
        return 2
    }//eom

    func sChart(chart: ShinobiChart!,
                seriesAtIndex index: Int) -> SChartSeries!
    {
        let lineSeries = SChartLineSeries()

        //fill graph
        lineSeries.style().showFill = true
        
        
        if index == 0
        {
            lineSeries.title = "y = cos(x)"
        }
        else
        {
            lineSeries.title = "y = sin(x)"
         }
        return lineSeries
    }//eom

    func sChart(chart: ShinobiChart!,
                numberOfDataPointsForSeriesAtIndex seriesIndex: Int) -> Int
    {
        return 100
    }//eom

    func sChart(chart: ShinobiChart!,
                dataPointAtIndex dataIndex: Int,
                forSeriesAtIndex seriesIndex: Int) -> SChartData!
    {
        let dataPoint = SChartDataPoint()

        //x values
        let xValue = Double(dataIndex) / 10.0
        dataPoint.xValue = xValue

        //y values
        if seriesIndex == 0
        {
            dataPoint.yValue = cos( Double(xValue) )
        }
        else
        {
            dataPoint.yValue = sin( Double(xValue) )
        }
        
        return dataPoint
    }//eom

}//eoc
