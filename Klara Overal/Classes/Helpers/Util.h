//
//  Util.h
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 25/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface Util : NSObject

+(BOOL)networkConnectionAvailable;
+ (id)createImageFromPNG:(NSString *)pngName InDirectory:(NSString *)dir DoYouWantImageView:(BOOL)imgView;
+(double)CalculateDistanceBetween2PointsWithP1Lat:(double)p1Lat P1Lon:(double)p1Lon P2Lat:(double)p2Lat P2Lon:(double)p2Lon;

@end
