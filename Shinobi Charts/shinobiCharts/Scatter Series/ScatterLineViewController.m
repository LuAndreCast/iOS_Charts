//
//  ScatterLineViewController.m
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ScatterLineViewController.h"
#import "ScatterLineGraphDataSource.h"

@interface ScatterLineViewController ()

@property (strong, nonatomic) ScatterLineGraphDataSource *datasource;
@property (strong, nonatomic) ShinobiChart *chart;


@property (strong, nonatomic) NSMutableArray *ranges;
@property (assign, nonatomic) CGRect chartFrame;


// Dictionary mapping series indices to mutable arrays of data point indices
@property (strong, nonatomic) NSMutableDictionary *selectedDonutIndices;

// Dictionary mapping series indices to rotation angles
@property (strong, nonatomic) NSMutableDictionary *rotations;

@end


@implementation ScatterLineViewController

@synthesize chartView;

//MARK: - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //chart init
    self.chart = [[ShinobiChart alloc]initWithFrame:self.chartView.bounds];
    [self.chartView addSubview:self.chart];
    self.chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //data source setup
    self.datasource = [[ScatterLineGraphDataSource alloc]init];
    self.chart .datasource = self.datasource;
    
    [self setupChart];
    [self setupTheme];
}//eom

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    /*
    // Save the current state
    self.chartFrame = self.chart.frame;
    self.ranges = [NSMutableArray new];
    for (SChartAxis *axis in self.chart.allAxes) 
     {
        [self.ranges addObject:axis.axisRange];
    }//eofl
    
    for (NSInteger i=0; i < self.chart.series.count; i++) 
     {
        SChartSeries* series = self.chart.series[i];
        if ([series isKindOfClass:[SChartDonutSeries class]]) 
     {
            self.rotations[@(i)] = @(((SChartDonutSeries *)series).rotation);
        }
    }//eofl
    */
    
    self.chart= nil;
    self.datasource = nil;
}//eom

#pragma mark - Setup
-(void)setupChart
{
    self.chart.title = @"Scatter Chart";
    
    self.chart.delegate = self;
    
    //Legend
    self.chart.legend.hidden = NO;
    
    //License Key
    self.chart.licenseKey = [[Constants shared] getLicenseKey];
    
    //AXIS Styling
    
    self.chart.xAxis = [SChartNumberAxis new];
    self.chart.xAxis.title = @"Height (inches)";
    self.chart.xAxis.rangePaddingLow = @1;
    self.chart.xAxis.rangePaddingHigh = @1;
    
    self.chart.yAxis = [SChartNumberAxis new];
    self.chart.yAxis.title = @"Average Weight (lbs)";
    self.chart.yAxis.rangePaddingLow = @3;
    self.chart.yAxis.rangePaddingHigh = @3;
    
    for (SChartAxis *axis in self.chart.allAxes) {
        axis.enableGesturePanning = YES;
        axis.enableGestureZooming = YES;
        axis.enableMomentumPanning = YES;
        axis.enableMomentumZooming = YES;
    }
    
  
}//eom

-(void)setupTheme
{
    SChartTheme * theme = [SChartiOS7Theme new];
    
    UIColor *darkGrayColor = [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
//    theme.chartTitleStyle.font = [UIFont shinobiFontOfSize:18];
    theme.chartTitleStyle.textColor = darkGrayColor;
    theme.chartTitleStyle.titleCentresOn = SChartTitleCentresOnChart;
    theme.chartStyle.backgroundColor = [UIColor whiteColor];
    theme.legendStyle.borderWidth = 0;
//    theme.legendStyle.font = [UIFont shinobiFontOfSize:16];
    theme.legendStyle.titleFontColor = darkGrayColor;
    theme.legendStyle.fontColor = darkGrayColor;
//    theme.crosshairStyle.defaultFont = [UIFont shinobiFontOfSize:14];
    theme.crosshairStyle.defaultTextColor = darkGrayColor;
    
    [self styleAxisStyle:theme.xAxisStyle useLightLabelFont:YES];
    [self styleAxisStyle:theme.yAxisStyle useLightLabelFont:YES];
    [self styleAxisStyle:theme.xAxisRadialStyle useLightLabelFont:NO];
    [self styleAxisStyle:theme.yAxisRadialStyle useLightLabelFont:NO];
    
    
    [self.chart applyTheme:theme];
}//eom

#pragma mark - Setup Helpers
- (void)styleAxisStyle:(SChartAxisStyle *)style useLightLabelFont:(BOOL)useLightLabelFont
{
    UIColor *darkGrayColor = [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
    
//    style.titleStyle.font = [UIFont shinobiFontOfSize:16];
    style.titleStyle.textColor = darkGrayColor;
    if (useLightLabelFont) {
//        style.majorTickStyle.labelFont = [UIFont lightShinobiFontOfSize:14];
    } else {
//        style.majorTickStyle.labelFont = [UIFont shinobiFontOfSize:14];
    }
    style.majorTickStyle.labelColor = style.titleStyle.textColor;
    style.majorTickStyle.lineColor = style.titleStyle.textColor;
    style.lineColor = style.titleStyle.textColor;
}//eom



/*
- (void)useHorizontalLegend
{
    chart.legend.style.orientation = SChartLegendOrientationHorizontal;
    chart.legend.style.horizontalPadding = @10;
    chart.legend.position = SChartLegendPositionBottomMiddle;
    chart.legend.style.symbolAlignment = SChartSeriesLegendAlignSymbolsLeft;
    chart.legend.style.textAlignment = NSTextAlignmentLeft;
}//eom
*/


#pragma mark - SChartDelegate methods

- (void)sChartDidFinishLoadingData:(ShinobiChart *)chart {
    // Restore the previous state of the chart
    
    // Ranges first
    if (self.ranges)
    {
        for (int i=0; i<self.chart.allAxes.count && i<self.ranges.count; i++) {
            if (self.ranges[i]) {
                SChartRange *range = (SChartRange *)self.ranges[i];
                [self.chart.allAxes[i] setRangeWithMinimum:range.minimum andMaximum:range.maximum];
            }
        }
    }
    
    // Now donut series selection and rotation (if applicable)
    for (NSInteger i=0; i < self.chart.series.count; i++)
    {
        SChartSeries* series = self.chart.series[i];
        NSNumber *seriesIndex = @(i);
        if ([series isKindOfClass:[SChartDonutSeries class]] && self.selectedDonutIndices[seriesIndex])
        {
            SChartDonutSeries *donutSeries = (SChartDonutSeries *) series;
            for (NSNumber *index in self.selectedDonutIndices[seriesIndex])
            {
                // Grab the appropriate data point and set it to be selected
                // NB: the docs tell you not to modify the data in SChartSeries.dataSeries but:
                // a) we can't really change the data source from here - we don't want to have
                // the charts based on this superclass to concern themselves with preserving the
                // chart state
                // b) we're not actually changing the data itself so we don't need to worry about
                // inconsistencies with the data source
                SChartDataPoint *dp = series.dataSeries.dataPoints[[index integerValue]];
                dp.selected = YES;
            }
            donutSeries.style.initialRotation = self.rotations[seriesIndex];
        }
    }
    
    [self setupAfterDataLoad];
}//eom


- (void)sChart:(ShinobiChart *)chart
        toggledSelectionForRadialPoint:(SChartRadialDataPoint *)dataPoint
              inSeries:(SChartRadialSeries *)series
            atPixelCoordinate:(CGPoint)pixelPoint
{
    
    // Keep track of the selected indices
    NSNumber *seriesIndex = @([chart.series indexOfObject:series]);
    if (!self.selectedDonutIndices[seriesIndex])
    {
        self.selectedDonutIndices[seriesIndex] = [NSMutableArray new];
    }
    
    if (dataPoint.selected)
    {
        [self.selectedDonutIndices[seriesIndex] addObject:@(dataPoint.index)];
    } else {
        [self.selectedDonutIndices[seriesIndex] removeObject:@(dataPoint.index)];
    }
}//eom

#pragma mark - Optionals
-(void)setupAfterDataLoad
{

}//eom


//MARK: - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
