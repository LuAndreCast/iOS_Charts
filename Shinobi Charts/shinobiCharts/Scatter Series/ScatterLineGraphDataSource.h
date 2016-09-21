//
//  ScatterLineGraphDataSource.h
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiCharts.h>

@interface ScatterLineGraphDataSource : NSObject<SChartDatasource>

@property (nonatomic, strong) NSDictionary *dataCollection;
@property (nonatomic, strong) NSArray *seriesNames;

@end
