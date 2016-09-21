//
//  File.swift
//  shinobiCharts
//
//  Created by Luis Castillo on 9/20/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class LineGraphModDataSource:NSObject, SChartDatasource
{
    
    var lineData = [
        [1,3],
        [2,4],
        [3,7],
        [6,9],
        [4,7]
    ]
    
    
    var dates = [ "08-15-2016", "08-20-2016", "08-21-2016", "08-22-2016", "08-24-2016"]
    
    let dateF:DateFormatter = DateFormatter()
    
    
    override init() {
        dateF.dateFormat = "MM-dd-yyyy"
        
    }//eom
    
    
    
    
    
    //MARK: - Helpers
    func getInititalDateRange()->SChartDateRange
    {
        let secsInDay:TimeInterval = 86400
        
        var startingDate:Date = self.getDateForValueAtIndex(index: 0)
        startingDate = Date(timeInterval: -secsInDay, since: startingDate)
        
        let lastIndex = dates.count-1
        var endingDate:Date = self.getDateForValueAtIndex(index: lastIndex)
        endingDate = Date(timeInterval: secsInDay, since: endingDate)
        
        let range:SChartDateRange = SChartDateRange(dateMinimum: startingDate, andDateMaximum: endingDate)
        
        return range
    }//eom
    
    
    func getDateForValueAtIndex(index:Int)->Date
    {
        var tempDate:Date = Date()
        
        let currDateString:String = dates[index]
        tempDate = dateF .date(from: currDateString)!
        
        return tempDate
    }//eom
    
    
    
    //MARK: SChartDatasource
    /** Returns the number of series in the given chart. For each of these series, the chart will expect to receive a `SChartSeries` object from the datasource, through the `sChart:seriesAtIndex:` method.
     */
    public func numberOfSeries(inSChart chart: ShinobiChart!) -> Int
    {
        return lineData.count;
    }//eom
    
    
    /** Returns the number of data points in the specified series.
     */
    public func sChart(_ chart: ShinobiChart!,
                       numberOfDataPointsForSeriesAt seriesIndex: Int) -> Int
    {
        var totalNum = 0
        if let data = lineData.first
        {
            totalNum = data.count
        }
        
        return totalNum
    }//eom
    
    /** Returns the object that represents the data point at the given index in the specified chart series.
    */
    public func sChart(_ chart: ShinobiChart!,
                       dataPointAt dataIndex: Int,
                       forSeriesAt seriesIndex: Int) -> SChartData!
    {
        let sData:SChartDataPoint = SChartDataPoint()
        
        let xVal:Date = self.getDateForValueAtIndex(index: seriesIndex)
        
        let seriesData = lineData[seriesIndex]
        let yVal = seriesData[dataIndex]
        
        sData.xValue = xVal
        sData.yValue = yVal
        
        return sData
    }//eom


    /** Returns the `SChartSeries` object at the given index in the specified chart. 
     */
    public func sChart(_ chart: ShinobiChart!,
                       seriesAt index: Int) -> SChartSeries!
    {
        let cSeries:SChartLineSeries = SChartLineSeries()
        
        //style
        let desiredStyle:SChartLineSeriesStyle = SChartLineSeriesStyle()
        desiredStyle.lineWidth = 3
        
        cSeries.setStyle(desiredStyle)
        
        //hiding from legend
        cSeries.showInLegend = false
        
        return cSeries;
    }//eom

    
    
}//eoc
