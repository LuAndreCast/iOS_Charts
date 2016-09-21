//
//  ScatterLineViewController.m
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "ScatterHRModifiedLineViewController.h"
#import "ScatterHRModifiedLineGraphDataSource.h"

@interface ScatterHRModifiedLineViewController ()

@property (strong, nonatomic) ScatterHRModifiedLineGraphDataSource *datasource;
@property (strong, nonatomic) ShinobiChart *chart;
@property (assign, nonatomic) CGRect chartFrame;

@end


@implementation ScatterHRModifiedLineViewController

@synthesize chartView;

//MARK: - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //chart init
    CGFloat margin = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10.0 : 30.0;
    self.chart = [[ShinobiChart alloc] initWithFrame:CGRectInset(self.chartView.bounds, margin, margin)];
    
    [self.chartView addSubview:self.chart];
    self.chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //data source setup
    self.datasource = [[ScatterHRModifiedLineGraphDataSource alloc]init];
    self.chart .datasource = self.datasource;
    
    [self setupChart];
    [self setupTheme];
    [self setupHorizontalLegend];
}//eom

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.chart= nil;
    self.datasource = nil;
}//eom

#pragma mark - Setup
-(void)setupChart
{
    self.chart.title = @"Heartrate Mod chart";
    
    self.chart.delegate = self;
    
    self.chart.crosshair = [[SChartSeriesCrosshair alloc]init];
    
    //Legend
    self.chart.legend.hidden = YES;
    
    //License Key
    self.chart.licenseKey = [[Constants shared] getLicenseKey];
    
    /* X Axis */
    self.chart.xAxis = [SChartDateTimeAxis new];
    self.chart.xAxis.title = @"Date";
    self.chart.xAxis.labelFormatString = @"MM dd yy";
    self.chart.xAxis.defaultRange = [self.datasource getInitialDateRange];
    self.chart.xAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    self.chart.xAxis.style.majorTickStyle.showLabels = NO;
    self.chart.xAxis.style.majorTickStyle.showTicks = YES;
    self.chart.xAxis.style.minorTickStyle.showTicks = YES;
    self.chart.xAxis.majorTickFrequency = [[SChartDateFrequency alloc]initWithDay:2];
    
    //axis movement
    self.chart.xAxis.enableGesturePanning = YES;
    self.chart.xAxis.enableGestureZooming = YES;
    self.chart.xAxis.enableMomentumPanning = YES;
    self.chart.xAxis.enableMomentumZooming = YES;
    
    
    /* Y Axis */
    self.chart.yAxis = [SChartNumberAxis new];
    self.chart.yAxis.defaultRange = [[SChartRange alloc]initWithMinimum:@60 andMaximum:@120];;
    self.chart.yAxis.title = @"Heart Rates";
    self.chart.yAxis.majorTickFrequency = @1;
    self.chart.yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    self.chart.yAxis.style.majorTickStyle.showLabels = NO;
    self.chart.yAxis.style.majorTickStyle.showTicks = YES;
    self.chart.yAxis.style.minorTickStyle.showTicks = YES;
    
    //axis movement
    self.chart.yAxis.enableGesturePanning = NO;
    self.chart.yAxis.enableGestureZooming = NO;
    self.chart.yAxis.enableMomentumPanning = NO;
    self.chart.yAxis.enableMomentumZooming = NO;
  
    
}//eom

-(void)setupTheme
{
    SChartTheme * theme = [SChartiOS7Theme new];
    
    UIColor *darkGrayColor = [UIColor colorWithRed:83.0/255 green:96.0/255 blue:107.0/255 alpha:1];
    theme.chartTitleStyle.font = [UIFont systemFontOfSize:18];
    theme.chartTitleStyle.textColor = darkGrayColor;
    theme.chartTitleStyle.titleCentresOn = SChartTitleCentresOnChart;
    theme.chartStyle.backgroundColor = [UIColor whiteColor];
    theme.legendStyle.borderWidth = 0;
    theme.legendStyle.font = [UIFont systemFontOfSize:16];
    theme.legendStyle.titleFontColor = darkGrayColor;
    theme.legendStyle.fontColor = darkGrayColor;
    theme.crosshairStyle.defaultFont = [UIFont systemFontOfSize:14];
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
    
    style.titleStyle.font = [UIFont systemFontOfSize:16];
    style.titleStyle.textColor = darkGrayColor;
    if (useLightLabelFont) {
        style.majorTickStyle.labelFont = [UIFont systemFontOfSize:14];
    } else {
        style.majorTickStyle.labelFont = [UIFont systemFontOfSize:14];
    }
    style.majorTickStyle.labelColor = style.titleStyle.textColor;
    style.majorTickStyle.lineColor = style.titleStyle.textColor;
    style.lineColor = style.titleStyle.textColor;
}//eom

- (void)setupHorizontalLegend
{
    self.chart.legend.hidden = NO;
    
    self.chart.legend.style.orientation = SChartLegendOrientationHorizontal;
    self.chart.legend.style.horizontalPadding = @10;
    self.chart.legend.position = SChartLegendPositionBottomMiddle;
    self.chart.legend.style.symbolAlignment = SChartSeriesLegendAlignSymbolsLeft;
    self.chart.legend.style.textAlignment = NSTextAlignmentLeft;
}//eom


        
@end
