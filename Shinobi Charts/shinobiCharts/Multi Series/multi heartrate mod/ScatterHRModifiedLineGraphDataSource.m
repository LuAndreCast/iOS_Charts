//
//  ScatterLineGraphDataSource.m
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ScatterHRModifiedLineGraphDataSource.h"

@implementation ScatterHRModifiedLineGraphDataSource


-(id)init {
    if(self = [super init])
    {
        self.seriesNames = @[@"before", @"after"];
        
        //date formatter
        self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:@"MM-dd-yyyy"];
        
        //data
        NSString *path = [[NSBundle mainBundle] pathForResource:@"scatter-HRModified-data" ofType:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSArray * tempData = [[NSMutableArray alloc] initWithContentsOfFile:path];
            
            if ( [tempData count] == 2)
            {
                self.dataCollection = tempData;
                self.beforeData = [self.dataCollection objectAtIndex:0];
                self.afterData = [self.dataCollection objectAtIndex:1];
            }
        }
        
    }
    return self;
}

#pragma mark - Graph Helpers
- (SChartAxis *)sChart:(ShinobiChart *)chart yAxisForSeriesAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        //the secondary axis
        SChartAxis * secondAxis = chart.allYAxes[1];
      
        /*
        //use the below to show second axis on the same side of first axis
        secondAxis.axisPosition = SChartAxisPositionNormal;
        secondAxis.style.majorTickStyle.showLabels = NO;
        secondAxis.style.majorTickStyle.showTicks = NO;
        secondAxis.style.lineColor = [UIColor clearColor];
        */
        
        return secondAxis;
    } else {
        //primary axis
        return chart.yAxis;
    }
}//eom

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

#pragma mark - Datasource methods
-(NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart
{
    NSInteger total = 0;
    
    //making sure data is avaliable
    if ([self.afterData count] > 0) {
        total = 2 + [self.afterData count];
    }
    
    return total;
}//eom

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index
{
    UIColor * shinobiBlueColor = [UIColor colorWithRed:1/255.f *.8 green:122/255.f *.8 blue:255/255.f *.8 alpha:1.f];
    UIColor * shinobiGreenColor = [UIColor colorWithRed:76/255.f *.8 green:217/255.f *.8 blue:100/255.f *.8 alpha:1.f];
    
    SChartSeries * series = nil;
    
    //scatter
    if (index < 2)
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
    //lines
    else
    {
        SChartLineSeries * lineSeries = [SChartLineSeries new];
        
        SChartLineSeriesStyle * seriesStyle = [[SChartLineSeriesStyle alloc]init];
        seriesStyle.lineWidth = @3;
        seriesStyle.lineColor = [UIColor darkGrayColor];
        
        [lineSeries set_style:seriesStyle];
        
        lineSeries.showInLegend = false;
        
        
        series = lineSeries;
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
    
    //heart rate values
    id heartRateValue = 0;
    
    //scatter points
    if(seriesIndex < 2)
    {
        
        if (seriesIndex == 0)
        {
            heartRateValue = [self getBeforeHeartRateValueForIndex:dataIndex];;
        }
        else if (seriesIndex == 1)
        {
            heartRateValue = [self getAfterHeartRateValueForIndex:dataIndex];
        }
    }
    //lines connecting data points
    else
    {
        //series index == array index
        //data index == before or after array
        
        NSInteger currSeriesIndex = seriesIndex-2;
        date = [self getDateFromIndex:currSeriesIndex];
        
        
        if (dataIndex == 0)
        {
            heartRateValue = [self getBeforeHeartRateValueForIndex:currSeriesIndex];
        }
        else if (dataIndex == 1)
        {
            heartRateValue = [self getAfterHeartRateValueForIndex:currSeriesIndex];
        }
    }
    
    dp.xValue = date;
    dp.yValue = heartRateValue;
    
    return dp;
}//eom




-(NSInteger)sChart:(ShinobiChart *)chart
numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    //assuming all series have the same amount of data
    if (seriesIndex < 2)
    {
        return [self.afterData count];
    }
    //line series only need to high/low
    else
    {
        return 2;
    }
    
}//eom



@end
