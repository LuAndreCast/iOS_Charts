//
//  StackedViewController.h
//  shinobiCharts
//
//  Created by Luis Castillo on 10/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackedDataSource.h"
#import <ShinobiCharts/ShinobiCharts.h>

#import "shinobiCharts-Swift.h"


@interface StackedViewController : UIViewController<SChartDelegate>

@property (weak, nonatomic) IBOutlet UIView *chartView;

@end
