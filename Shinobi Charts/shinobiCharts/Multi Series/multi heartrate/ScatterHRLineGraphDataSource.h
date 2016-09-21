//
//  ScatterLineGraphDataSource.h
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiCharts.h>

@interface ScatterHRLineGraphDataSource : NSObject<SChartDatasource>


-(SChartDateRange *)getInitialDateRange;

@property (nonatomic, strong) NSArray *dataCollection;
@property (nonatomic, strong) NSArray *afterData;
@property (nonatomic, strong) NSArray *beforeData;
@property (nonatomic, strong) NSArray *seriesNames;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end
