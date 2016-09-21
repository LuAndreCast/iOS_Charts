//
//  MultiGraphDataSource.h
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiCharts.h>

@interface MultiGraphDataSource : NSObject<SChartDatasource>

- (SChartDateRange *)getInitialDateRange;

@property (strong, nonatomic) NSArray *seriesTitles;
@property (strong, nonatomic) NSDateComponents *dateComponents;
@property (strong, nonatomic) NSCalendar *calendar;

@property (nonatomic, strong) NSArray *dataCollection;
@property (nonatomic,strong) NSArray *seriesNames;

@end
