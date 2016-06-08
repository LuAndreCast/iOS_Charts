//
//  TornadoDataSource.m
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//


#import "TornadoDataSource.h"
#import "TornadoDataPoint.h"

@implementation TornadoDataSource

-(id)init {
    if(self = [super init]) {
        _data = @[[[TornadoDataPoint alloc] initWithMin:@45 max:@53 andCategoryName:@"First"],
                 [[TornadoDataPoint alloc] initWithMin:@55 max:@40 andCategoryName:@"Second"],
                 [[TornadoDataPoint alloc] initWithMin:@38 max:@60 andCategoryName:@"Third"],
                 [[TornadoDataPoint alloc] initWithMin:@32 max:@70 andCategoryName:@"Fourth"],
                 [[TornadoDataPoint alloc] initWithMin:@75 max:@25 andCategoryName:@"Fifth"],
                 [[TornadoDataPoint alloc] initWithMin:@20 max:@80 andCategoryName:@"Sixth"],
                 [[TornadoDataPoint alloc] initWithMin:@5 max:@90 andCategoryName:@"Seventh"]];
    }
    return self;
}

-(int)numberOfSeriesInSChart:(ShinobiChart*)chart {
    return 3; // 0 is the hidden padding series, 1 is the min series and 2 is the max series.
}

-(SChartSeries*)sChart:(ShinobiChart*)chart seriesAtIndex:(int)index {
    SChartBarSeries *barSeries = [SChartBarSeries new];
    
    // Set the stack index to be the same for everthing - that way the bars will stack alongside each other.
    barSeries.stackIndex = @1;
    
    // Hide the first series - that series just acts as padding for the left of our chart. 
    if(index == 0) {
        barSeries.style.lineColor = [UIColor clearColor];
        barSeries.style.showArea = NO;
        // We don't set barSeries.hidden = NO as this would remove the series and there would be no padding!
    }
    return barSeries;
}

-(int)sChart:(ShinobiChart*)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    return _data.count;
}

-(id<SChartData>)sChart:(ShinobiChart*)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
    TornadoDataPoint *tornadoData = [_data objectAtIndex:dataIndex];
    
    NSNumber *xVal;
    if(seriesIndex == 0) {
        // The first series is padding. We want the next bar to start at the min value, so just set it to that.
        xVal = tornadoData.min;
    }
    else if(seriesIndex == 1) {
        // The second series is the min value bar. We want to end at the base value, so subtract that.
        xVal = [NSNumber numberWithDouble:_base.doubleValue - tornadoData.min.doubleValue];
    }
    else {
        // The third and final series is the right x value. This will extend to the right of the base point.
        xVal = [NSNumber numberWithDouble:tornadoData.max.doubleValue - _base.doubleValue];
    }
    
    SChartDataPoint *dataPoint = [SChartDataPoint new];
    dataPoint.xValue = xVal;
    dataPoint.yValue = tornadoData.category;
    return dataPoint;
}

@end