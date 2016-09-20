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
        chart?.licenseKey =  Constants.shared.getLicenseKey()
        
        chart?.title             = "Simple Chart #1"
        chart?.datasource        = self
        chart?.autoresizingMask  = [.flexibleHeight , .flexibleWidth]
        
        chartView.addSubview(chart!)
    }//eom
    
    
    //MARK: - Chart Datasource
    func numberOfSeries(inSChart chart: ShinobiChart!) -> Int
    {
        return 1
    }//eom
    
    func sChart(_ chart: ShinobiChart!, seriesAt index: Int) -> SChartSeries!
    {
        return SChartLineSeries()
    }//eom
    
    func sChart(_ chart: ShinobiChart!, numberOfDataPointsForSeriesAt seriesIndex: Int) -> Int {
        return 100
    }//eom
    
    func sChart(_ chart: ShinobiChart!, dataPointAt dataIndex: Int, forSeriesAt seriesIndex: Int) -> SChartData!
    {
        let dp = SChartDataPoint()
        dp.xValue = dataIndex
        dp.yValue = dataIndex * dataIndex
        return dp
    }//eom
    
}//eoc

