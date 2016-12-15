//
//  MultiGraphDataSource.m
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "MultiGraphDataSource.h"

@interface MultiGraphDataSource()


@end

@implementation MultiGraphDataSource


-(id)init {
    if(self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"multitype-data" ofType:@"plist"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            self.dataCollection = [[NSMutableArray alloc] initWithContentsOfFile:path];
        }
        self.seriesTitles = @[@"Rainfall (mm)", @"Max/Min Temp (C)"];
        
        self.dateComponents = [NSDateComponents new];
        [self.dateComponents setDay:1];
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return self;
}//eom


#pragma mark - Graph Helper
- (NSDate *)convertIndexToDate:(NSInteger)dataIndex {
    // Data in plist is monthly data starting at January 2000, so we use the dataIndex to
    // calculate the month and year
    self.dateComponents.month = (dataIndex%12)+1;
    self.dateComponents.year = dataIndex/12 + 2000;
    
    NSDate * finDate = [self.calendar dateFromComponents:self.dateComponents];
    
    return finDate;
}//eom


#pragma mark - Multi part delegate
// Show about a third of the data in the initial range
- (SChartDateRange *)getInitialDateRange
{
    NSDate * minDate = [self convertIndexToDate:0];
    NSInteger maxDateIndex = self.dataCollection.count/4;
    NSDate * maxDate = [self convertIndexToDate:maxDateIndex];
    SChartDateRange * range = [[SChartDateRange alloc]initWithDateMinimum:minDate andDateMaximum:maxDate];
    
    return  range;
}//eom


- (SChartAxis *)sChart:(ShinobiChart *)chart yAxisForSeriesAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        // Rainfall series, so we need the secondary axis
        SChartAxis * secondAxis = chart.allYAxes[1];
   
    /* //use the below to show second axis on the same side of first axis
         secondAxis.axisPosition = SChartAxisPositionNormal;
        secondAxis.style.majorTickStyle.showLabels = NO;
        secondAxis.style.majorTickStyle.showTicks = NO;
        secondAxis.style.lineColor = [UIColor clearColor];
        secondAxis.titleLabel.text = @"Rainfall (mm)";
        */
        
        return secondAxis;
    } else {
        // Temperature series, so we use the primary axis
        return chart.yAxis;
    }
}//eom

#pragma mark - Datasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 2;
}//eom

- (SChartSeries *)sChart:(ShinobiChart *)chart
           seriesAtIndex:(NSInteger)index {
    
    SChartSeries *series = nil;
    
    UIColor * blueColor = [UIColor colorWithRed:1/255.f *.8 green:122/255.f *.8 blue:255/255.f *.8 alpha:1.f];
    UIColor * redColor = [UIColor colorWithRed:255/255.f *.9 green:45/255.f *.9 blue:85/255.f *.9 alpha:1.f];
    UIColor * orangeColor = [UIColor colorWithRed:255/255.f *.9 green:149/255.f *.9 blue:1/255.f *.9 alpha:1.f];
   
    UIColor * lighRedColor = redColor;
    CGFloat h, s, b, a;
    if ( [redColor getHue:&h saturation:&s brightness:&b alpha:&a])
    {
        lighRedColor = [UIColor colorWithHue:h saturation:0.5 brightness:0.8 alpha:a];
        lighRedColor = [lighRedColor colorWithAlphaComponent:0.5];
    }
    
    // Rainfall: column series
    if(index == 0)
    {
        SChartColumnSeries *columnSeries = [SChartColumnSeries new];
        columnSeries.style.areaColor = blueColor;
        columnSeries.style.showAreaWithGradient = NO;
        series = columnSeries;
    }
    // Temperature: band series
    else
    {
        SChartBandSeries *bandSeries = [SChartBandSeries new];
        bandSeries.style.lineWidth = @2;
        bandSeries.style.lineColorHigh = redColor;
        bandSeries.style.lineColorLow = orangeColor;
        bandSeries.style.areaColorNormal = lighRedColor;
        bandSeries.style.areaColorInverted = bandSeries.style.areaColorNormal;
        series = bandSeries;
    }
    
    id title = self.seriesTitles[index];
    series.title = title;
    
    return series;
}//eom


- (id<SChartData>)sChart:(ShinobiChart *)chart
        dataPointAtIndex:(NSInteger)dataIndex
        forSeriesAtIndex:(NSInteger)seriesIndex
{
    SChartDataPoint *dataPoint = [SChartDataPoint new];
    
    
    id xValue = [self convertIndexToDate:dataIndex];
    
    // Rainfall
    if (seriesIndex == 0)
    {
        id yValue = self.dataCollection[dataIndex][@"mm_rain"];
        
        dataPoint.xValue = xValue;
        dataPoint.yValue = yValue;
    }
    // Temperature is a band, so needs a multi data point
    else
    {
        id yMinVal = self.dataCollection[dataIndex][@"min_temp"];
        id yMaxVal = self.dataCollection[dataIndex][@"max_temp"];
        id yValue = [ @{SChartBandKeyLow : yMinVal,  SChartBandKeyHigh : yMaxVal } mutableCopy];
        
        SChartMultiYDataPoint *multiDataPoint = [SChartMultiYDataPoint new];
        multiDataPoint.xValue = xValue;
        multiDataPoint.yValues = yValue;
        
        dataPoint = multiDataPoint;
    }
    
    return dataPoint;
}//eom


- (NSInteger)sChart:(ShinobiChart *)chart
numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    return self.dataCollection.count;
}//eom

@end
