//
//  CandlestickViewController.h
//  shinobiCharts
//
//  Created by Luis Castillo on 9/28/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiCharts.h>
#import "shinobiCharts-Swift.h"

#import "CandlestickDatasource.h"

@interface CandlestickViewController : UIViewController<SChartDelegate>

@property (weak, nonatomic) IBOutlet UIView *chartView;


@end
