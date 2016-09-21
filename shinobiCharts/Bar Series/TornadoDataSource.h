//
//  TornadoDataSource.h
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiCharts.h>

@interface TornadoDataSource : NSObject <SChartDatasource>


@property NSNumber *base;
@property NSArray *data;

@end
