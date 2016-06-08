//
//  ViewController.swift
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, SChartDatasource
{
    @IBOutlet weak var chartView: UIView!
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let chart = ShinobiChart(frame: chartView.bounds)
        chart.licenseKey =  shinobiTrialLicenseKey
        
        chart.title             = "Simple Chart #1"
        chart.datasource        = self
        chart.autoresizingMask  = [.FlexibleHeight , .FlexibleWidth]
        
        chartView.addSubview(chart)
    }//eom
    
    
    //MARK: - Chart Datasource
    func numberOfSeriesInSChart(chart: ShinobiChart!) -> Int
    {
        return 1
    }//eom
    
    func sChart(chart: ShinobiChart!, seriesAtIndex index: Int) -> SChartSeries!
    {
        return SChartLineSeries()
    }//eom
    
    func sChart(chart: ShinobiChart!, numberOfDataPointsForSeriesAtIndex seriesIndex: Int) -> Int {
        return 100
    }//eom
    
    func sChart(chart: ShinobiChart!, dataPointAtIndex dataIndex: Int, forSeriesAtIndex seriesIndex: Int) -> SChartData!
    {
        let dp = SChartDataPoint()
        dp.xValue = dataIndex
        dp.yValue = dataIndex * dataIndex
        return dp
    }//eom
    
}//eoc

