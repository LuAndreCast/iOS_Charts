//
//  TornadoDataPoint.m
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import "TornadoDataPoint.h"

@implementation TornadoDataPoint

-(id)initWithMin:(NSNumber*)min max:(NSNumber*)max andCategoryName:(NSString*)cat
{
    if (self = [super init])
    {
        self.min        = min;
        self.max        = max;
        self.category   = cat;
    }
    return self;
}


@end
