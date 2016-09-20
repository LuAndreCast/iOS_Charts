//
//  FourthViewController.swift
//  shinobiCharts
//
//  Created by Luis Castillo on 8/30/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController, SChartDelegate
{
    var chart:ShinobiChart = ShinobiChart(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let dataSource:LineHighLowGraphDataSource = LineHighLowGraphDataSource()
    
    @IBOutlet weak var chartView: UIView!
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let chart = ShinobiChart(frame: chartView.bounds)
        
//        let chart = ShinobiChart(frame: chartView.bounds, withPrimaryXAxisType: SChartAxisTypeNumber, withPrimaryYAxisType: SChartAxisTypeNumber)
        
        chart?.licenseKey =  Constants.shared.getLicenseKey()
        chart?.title             = "Chart #4"
        chart?.autoresizingMask  = [.flexibleHeight , .flexibleWidth]
        chart?.datasource = dataSource
        
        
        chartView.addSubview(chart!)
        
        //padding
//        chart.xAxis.rangePaddingLow = 0.5;
//        chart.yAxis.rangePaddingHigh = 0.5;
    }//eom

}//eoc
