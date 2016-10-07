//
//  CandlestickDatasource.m
//  shinobiCharts
//
//  Created by Luis Castillo on 9/28/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "CandlestickDatasource.h"

@implementation CandlestickDatasource


- (instancetype)init {
    self = [super init];

    if (self) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ChartsGallery-candlestick-data" ofType:@"plist"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            self.dataCollection = [[NSMutableArray alloc] initWithContentsOfFile:path];
        }
        
        self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:@"MM-dd-yyyy"];
    }
    return self;
}


#pragma mark - SChartDatasource Helper methods

- (id)xValueAtIndex:(NSInteger)dataIndex
   forSeriesAtIndex:(NSInteger)seriesIndex {
    
    NSString * dateString = self.dataCollection[dataIndex][@"date"];
    NSDate * date = [self.dateFormatter dateFromString:dateString];
    
    return date;
}//eom


- (id)yValuesAtIndex:(NSInteger)dataIndex
    forSeriesAtIndex:(NSInteger)seriesIndex
{
    return [@{SChartCandlestickKeyLow : self.dataCollection[dataIndex][@"low"],
              SChartCandlestickKeyHigh : self.dataCollection[dataIndex][@"high"],
              SChartCandlestickKeyOpen : self.dataCollection[dataIndex][@"open"],
              SChartCandlestickKeyClose : self.dataCollection[dataIndex][@"close"]}
            mutableCopy];
}

#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart
{
    if (self.dataCollection.count > 0) {
        return 1;
    }
    
    return 0;
}//eom

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    return self.dataCollection.count;
}//eom


- (SChartSeries *)sChart:(ShinobiChart *)chart
           seriesAtIndex:(NSInteger)index
{
    SChartCandlestickSeries *series = [[SChartCandlestickSeries alloc] init];
    return series;
}//eom


- (id<SChartData>)sChart:(ShinobiChart *)chart
        dataPointAtIndex:(NSInteger)dataIndex
        forSeriesAtIndex:(NSInteger)seriesIndex
{
    SChartMultiYDataPoint *dp = [[SChartMultiYDataPoint alloc] init];
    dp.xValue = [self xValueAtIndex:dataIndex forSeriesAtIndex:seriesIndex];
    dp.yValues = [self yValuesAtIndex:dataIndex forSeriesAtIndex:seriesIndex];
    return dp;
}//eom

@end
