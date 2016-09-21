//
//  ScatterLineGraphDataSource.m
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ScatterHRLineGraphDataSource.h"

@implementation ScatterHRLineGraphDataSource


-(id)init {
    if(self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"scatter-HeartRate-data" ofType:@"plist"];
        
        self.seriesNames = @[@"before", @"after"];
        
        self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:@"MM-dd-yyyy"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSArray * tempData = [[NSMutableArray alloc] initWithContentsOfFile:path];
            
            if ( [tempData count] == 2)
            {
                self.dataCollection = tempData;
                self.afterData = [self.dataCollection objectAtIndex:1];
                self.beforeData = [self.dataCollection objectAtIndex:0];
            }
        }
        
    }
    return self;
}

#pragma mark - Graph Helpers

//assuming all data points have the same dates
-(NSDate *)getDateFromIndex:(NSInteger)index
{
    NSDate * date = [NSDate date];
    if (index < [self.afterData count])
    {
        NSDictionary * dateData = [self.afterData objectAtIndex:index];
        NSString * dateString = [dateData objectForKey:@"Date"];
        date = [self.dateFormatter dateFromString:dateString];
    }
        
    return date;
}//eom

-(id)getBeforeHeartRateValueForIndex:(NSInteger)dataIndex
{
    NSDictionary * currData = self.beforeData[dataIndex];
    
    id yValue = currData[@"Value"];
    
    return yValue;
}//eom


-(id)getAfterHeartRateValueForIndex:(NSInteger)dataIndex
{
    NSDictionary * currData = self.afterData[dataIndex];
    
    id yValue = currData[@"Value"];
    
    return yValue;
}//eom


#pragma mark - Multi part methods
-(SChartDateRange *)getInitialDateRange
{
    NSInteger lastIndex = [self.afterData count];
    lastIndex = lastIndex-1;
    
    NSDate * minDate = [self getDateFromIndex:0];
    NSDate * maxDate = [self getDateFromIndex:lastIndex];
    SChartDateRange * range = [[SChartDateRange alloc]initWithDateMinimum:minDate andDateMaximum:maxDate];
    
    return range;
}//eom

-(SChartAxis *)sChart:(ShinobiChart *)chart yAxisForSeriesAtIndex:(NSInteger)index
{
     //secondary axis
    if (index == 0)
    {
        SChartAxis * secondAxis = chart.allYAxes[1];
        
        //hiding axis in chart
        secondAxis.style.minorTickStyle.showLabels = NO;
        secondAxis.style.minorTickStyle.showTicks = NO;
        secondAxis.style.majorTickStyle.showLabels = NO;
        secondAxis.style.majorTickStyle.showTicks = NO;
       
        return secondAxis;
    }
    //primary axis
    else
    {
        return chart.yAxis;
    }
}//eom



#pragma mark - Datasource methods
-(NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart
{
    return 3;
}//eom

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index
{
    UIColor * shinobiBlueColor = [UIColor colorWithRed:1/255.f *.8 green:122/255.f *.8 blue:255/255.f *.8 alpha:1.f];
    UIColor * shinobiGreenColor = [UIColor colorWithRed:76/255.f *.8 green:217/255.f *.8 blue:100/255.f *.8 alpha:1.f];
    UIColor * lightGrayColor = [UIColor colorWithRed:238/255.f  green:238/255.f blue:238/255.f alpha:1.0f];
    
    SChartSeries * series = nil;
    
    //Line connecting before and after
    if (index == 2)
    {
        SChartBandSeries *lineConnecting = [SChartBandSeries new];
        lineConnecting.style.lineWidth = @2;
        lineConnecting.style.lineColorHigh = shinobiBlueColor;
        lineConnecting.style.lineColorLow = shinobiGreenColor;
        lineConnecting.style.areaColorNormal = lightGrayColor;
        lineConnecting.style.areaColorInverted = lineConnecting.style.areaColorNormal;

        //hiding from legend
        lineConnecting.showInLegend = NO;
        
        series = lineConnecting;
    }
    //before
    else
    {
        NSString * seriesTitle;
        UIColor * seriesColor;
        
        if (index == 0)
        {
            seriesTitle = @"Before";
            seriesColor =  shinobiBlueColor;
        }
        else {
            seriesTitle = @"After";
            seriesColor = shinobiGreenColor;
        }
        
        SChartScatterSeries * beforeAndAfterSeries = [SChartScatterSeries new];
        
        //Styling
        beforeAndAfterSeries.title = seriesTitle;
        
        //Points
        beforeAndAfterSeries.style.pointStyle.showPoints = YES;
        beforeAndAfterSeries.style.pointStyle.radius = @10;
        beforeAndAfterSeries.style.pointStyle.innerColor = seriesColor;
        
        //labels
        beforeAndAfterSeries.style.dataPointLabelStyle.showLabels = YES;
        beforeAndAfterSeries.style.dataPointLabelStyle.offsetFromDataPoint = CGPointMake(0, -15);
        beforeAndAfterSeries.style.dataPointLabelStyle.displayValues = SChartDataPointLabelDisplayValuesY;
        
        
        series = beforeAndAfterSeries;
    }
    
    
    //crosshair
    series.crosshairEnabled = true;
    
    return series;
}//eom



-(id<SChartData>)sChart:(ShinobiChart *)chart
       dataPointAtIndex:(NSInteger)dataIndex
       forSeriesAtIndex:(NSInteger)seriesIndex
{
    
    SChartDataPoint *dp = [SChartDataPoint new];
    
    NSDate * date = [self getDateFromIndex:dataIndex];
    id heartRateValue = 0;
    //line connecting before and after
    if (seriesIndex == 2)
    {
        //heart rate values
        id beforeHeartRateValue = [self getBeforeHeartRateValueForIndex:dataIndex];
        id afterHeartRateValue = [self getAfterHeartRateValueForIndex:dataIndex];
        
        //y values
        id lowVal;
        id highVal;
        if (afterHeartRateValue >= beforeHeartRateValue)
        {
            lowVal = beforeHeartRateValue;
            highVal = afterHeartRateValue;
        }
        else
        {
            lowVal = afterHeartRateValue;
            highVal = beforeHeartRateValue;
        }
        
        id yValue = [ @{SChartBandKeyLow : lowVal , SChartBandKeyHigh : highVal} mutableCopy];
        
        SChartMultiYDataPoint *multiDataPoint = [SChartMultiYDataPoint new];
        multiDataPoint.xValue = date;
        multiDataPoint.yValues = yValue;
   
        return multiDataPoint;
    }
    else if (seriesIndex == 1)
    {
        heartRateValue = [self getAfterHeartRateValueForIndex:dataIndex];
    }
    else if (seriesIndex == 0)
    {
        heartRateValue = [self getBeforeHeartRateValueForIndex:dataIndex];
    }
    
    dp.xValue = date;
    dp.yValue = heartRateValue;
    
    return dp;
}//eom




-(NSInteger)sChart:(ShinobiChart *)chart
numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    //assuming count is the same as after heart rate data
    NSInteger totalDataInSeries = [self.afterData count];
    
    return totalDataInSeries;
}//eom



@end
