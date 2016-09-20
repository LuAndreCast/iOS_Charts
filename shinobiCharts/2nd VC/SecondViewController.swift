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

        let margin = (UIDevice.current.userInterfaceIdiom == .phone ) ? CGFloat(10) : CGFloat(50)
        
        /* take into consideration Navigation Bar */
        var viewBounds:CGRect = view.bounds
        if let navBarHeight:CGFloat = self.navigationController?.navigationBar.frame.size.height
        {
            let calcY:CGFloat = ( navBarHeight + CGFloat.init(20))
            let calcHeight = viewBounds.height - calcY
            
            viewBounds = CGRect(x: 0, y: calcY , width: viewBounds.width, height: calcHeight)
        }
        let chart = ShinobiChart( frame: viewBounds.insetBy(dx: margin, dy: margin) )

        chart?.licenseKey        = Constants.shared.getLicenseKey()
        chart?.title             = "Simple Chart #2"
        chart?.autoresizingMask  =  [.flexibleHeight , .flexibleWidth]
        chart?.datasource        = self

        let xAxis   = SChartNumberAxis()
        xAxis?.title = "X Value"
        xAxis?.enableGesturePanning = true
        xAxis?.enableGestureZooming = true
        chart?.xAxis = xAxis

        let yAxis   = SChartNumberAxis()
        yAxis?.title = "Y Value"
        yAxis?.enableGesturePanning = true
        yAxis?.enableGestureZooming = true
        yAxis?.rangePaddingLow   = 0.1
        yAxis?.rangePaddingHigh  = 0.1
        chart?.yAxis = yAxis
        
        //shows legend on ipad only
        chart?.legend.isHidden = UIDevice.current.userInterfaceIdiom == .phone

        
        view.addSubview(chart!)
    }//eom


    //MARK: - Chart Datasource
    func numberOfSeries(inSChart chart: ShinobiChart!) -> Int {
        return 2
    }//eom

    func sChart(_ chart: ShinobiChart!,
                seriesAt index: Int) -> SChartSeries!
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

    func sChart(_ chart: ShinobiChart!,
                numberOfDataPointsForSeriesAt seriesIndex: Int) -> Int
    {
        return 100
    }//eom

    func sChart(_ chart: ShinobiChart!,
                dataPointAt dataIndex: Int,
                forSeriesAt seriesIndex: Int) -> SChartData!
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
