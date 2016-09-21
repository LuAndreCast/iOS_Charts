//
//  LineHighLowGraphDataSource.m
//  shinobiCharts
//
//  Created by Luis Castillo on 8/30/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "LineHighLowGraphDataSource.h"



@implementation LineHighLowGraphDataSource

-(id)init {
    if(self = [super init]) {
        heartRateData = [[NSArray alloc]initWithObjects:@"1" ,@"10", @"40" ,@"57", nil];
    }
    return self;
}


#pragma mark - Datasource methods

-(NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart
{
    return 1;
}

-(NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    return [heartRateData count];
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index
{
    SChartColumnSeries *series = [SChartColumnSeries new];
    
    //Display labels
    series.style.dataPointLabelStyle.showLabels = YES;
    
    //Position labels
    series.style.dataPointLabelStyle.offsetFromDataPoint = CGPointMake(0, -15);
    series.style.dataPointLabelStyle.offsetFlippedForNegativeValues = YES;
    
    //Style labels
    series.style.dataPointLabelStyle.textColor = [UIColor blackColor];
    series.style.dataPointLabelStyle.displayValues = SChartDataPointLabelDisplayValuesBoth;
    
    return series;
}//eom

-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex
{
    SChartDataPoint *dp = [SChartDataPoint new];
    dp.xValue = @(dataIndex);
    dp.yValue = [heartRateData objectAtIndex:dataIndex];
    return dp;
}


@end
