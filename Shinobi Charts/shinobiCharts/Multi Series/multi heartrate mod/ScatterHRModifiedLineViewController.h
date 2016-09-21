//
//  ScatterLineViewController.h
//  shinobiCharts
//
//  Created by Luis Castillo on 8/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiCharts/ShinobiCharts.h>


#import "shinobiCharts-Swift.h"

@interface ScatterHRModifiedLineViewController : UIViewController<SChartDelegate>

@property (weak, nonatomic) IBOutlet UIView *chartView;



@end
