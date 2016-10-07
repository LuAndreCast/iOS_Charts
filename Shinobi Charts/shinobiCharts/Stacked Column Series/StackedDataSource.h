//
//  StackedDataSource.h
//  shinobiCharts
//
//  Created by Luis Castillo on 10/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiCharts.h>

@interface StackedDataSource : NSObject<SChartDatasource>

@property (nonatomic, strong) NSArray *dataCollection;
@property (nonatomic,strong) NSArray *seriesNames;

@property (nonatomic,strong) NSArray *categories;
@property (nonatomic,strong) NSArray *seriesTitles;

@end
