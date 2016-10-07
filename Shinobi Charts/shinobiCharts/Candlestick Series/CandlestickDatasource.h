//
//  CandlestickDatasource.h
//  shinobiCharts
//
//  Created by Luis Castillo on 9/28/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiCharts.h>
#import "shinobiCharts-Swift.h"

@interface CandlestickDatasource : NSObject<SChartDatasource>


@property (nonatomic, strong) NSArray *dataCollection;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

//delete me below
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic,strong) NSArray *seriesNames;
@property (strong, nonatomic) NSDateComponents *dateComponents;
@property (strong, nonatomic) NSCalendar *calendar;

@end
