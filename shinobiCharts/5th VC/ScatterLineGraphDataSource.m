//
//  ScatterLineGraphDataSource.m
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ScatterLineGraphDataSource.h"

@implementation ScatterLineGraphDataSource


-(id)init {
    if(self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"scatter-data" ofType:@"plist"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            self.dataCollection = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        }
        self.seriesNames = @[@"male", @"female"];
    }
    return self;
}


#pragma mark - Datasource methods

-(NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart
{
    return 2;
}//eom

-(NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex
{
    NSInteger totalDataInSeries = 1;
    NSString * seriesTitle = self.seriesNames[seriesIndex];
    NSArray * currSeriesData = self.dataCollection[seriesTitle];
    totalDataInSeries = [currSeriesData count];
    return totalDataInSeries;

}//eom

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index
{
    UIColor * shinobiBlueColor = [UIColor colorWithRed:1/255.f *.8 green:122/255.f *.8 blue:255/255.f *.8 alpha:1.f];
    UIColor * shinobiGreenColor = [UIColor colorWithRed:76/255.f *.8 green:217/255.f *.8 blue:100/255.f *.8 alpha:1.f];
    
    NSString * seriesTitle = [self.seriesNames[index] capitalizedString];
    UIImage * seriesImage = [UIImage imageNamed:seriesTitle];
    
    SChartScatterSeries *series = [SChartScatterSeries new];
    series.title = seriesTitle;
    series.style.pointStyle.radius = @40;
    series.style.pointStyle.texture = seriesImage;
    series.style.pointStyle.innerColor = (index == 0) ? shinobiBlueColor: shinobiGreenColor;
    

    return series;
}//eom

-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex
{
    SChartDataPoint *dp = [SChartDataPoint new];
    
    NSString * seriesTitle = self.seriesNames[seriesIndex];
    NSArray * currSeriesData = self.dataCollection[seriesTitle];
    NSDictionary * currData = currSeriesData[dataIndex];
    
    NSString * height = currData[@"height"];
    id weight = currData[@"weight"];
    
    dp.xValue = height;
    dp.yValue = weight;
    return dp;
    
}//eom

@end
