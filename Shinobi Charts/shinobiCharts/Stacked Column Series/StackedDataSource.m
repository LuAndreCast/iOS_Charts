//
//  StackedDataSource.m
//  shinobiCharts
//
//  Created by Luis Castillo on 10/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "StackedDataSource.h"

@implementation StackedDataSource


-(id)init {
    if(self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"stackedColumn-data" ofType:@"plist"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            self.dataCollection = [[NSMutableArray alloc] initWithContentsOfFile:path];
        }
        
        self.seriesNames = @[@"q1", @"q2", @"q3", @"q4"];
        self.seriesTitles = @[@"Quarter 1", @"Quarter 2", @"Quarter 3", @"Quarter 4"];
        self.categories = @[@"Ford", @"VW", @"BMW", @"Nissan", @"Toyota", @"Honda"];
        
    }
    return self;
}//eom


#pragma mark - Graph Helper

- (id)xValueAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    return self.categories[dataIndex];
}

- (id)yValueAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    // We want to display data in 100,000s
    return @([self.dataCollection[dataIndex][self.seriesNames[seriesIndex]] floatValue] / 100000.f);
}


#pragma mark - Datasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    if (self.seriesNames == nil) {
        return 1;
    } else {
        return self.seriesNames.count;
    }
}//eom

- (SChartSeries *)sChart:(ShinobiChart *)chart
           seriesAtIndex:(NSInteger)index {
    
    SChartColumnSeries *series = [SChartColumnSeries new];
    series.title = self.seriesTitles[index];
    series.stackIndex = @1;
    
    
    
    return series;
}//eom


- (id<SChartData>)sChart:(ShinobiChart *)chart
        dataPointAtIndex:(NSInteger)dataIndex
        forSeriesAtIndex:(NSInteger)seriesIndex
{
    SChartDataPoint *dataPoint = [SChartDataPoint new];
    dataPoint.xValue = [self xValueAtIndex:dataIndex forSeriesAtIndex:seriesIndex];
    dataPoint.yValue = [self yValueAtIndex:dataIndex forSeriesAtIndex:seriesIndex];
    
    return dataPoint;
}//eom


- (NSInteger)sChart:(ShinobiChart *)chart
numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    return self.dataCollection.count;
}//eom




@end
