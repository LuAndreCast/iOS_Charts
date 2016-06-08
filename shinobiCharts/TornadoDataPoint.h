//
//  TornadoDataPoint.h
//  shinobiCharts
//
//  Created by Luis Castillo on 4/4/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TornadoDataPoint : NSObject

@property NSNumber *min;
@property NSNumber *max;
@property NSString *category;

-(id)initWithMin:(NSNumber*)min
             max:(NSNumber*)max
 andCategoryName:(NSString*)cat;


@end
