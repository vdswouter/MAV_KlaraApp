//
//  Util.m
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 25/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "Util.h"

@implementation Util

+(BOOL)networkConnectionAvailable{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Netwerk probleem" message:@"Er is geen werkende internetverbinding aanwezig. Zet 3G aan of verbind met een WIFI netwerk." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        return NO;
    } else {
        NSLog(@"There IS internet connection");
        return YES;
    }
}


+ (id)createImageFromPNG:(NSString *)pngName InDirectory:(NSString *)dir DoYouWantImageView:(BOOL)imgView{
    NSString *path = [[NSBundle mainBundle] pathForResource:pngName ofType:@"png" inDirectory:dir];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    if(imgView){
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        return imgView;
    }else{
        return img;
    }
}

+(double)CalculateDistanceBetween2PointsWithP1Lat:(double)p1Lat P1Lon:(double)p1Lon P2Lat:(double)p2Lat P2Lon:(double)p2Lon{
    return acos( sin(p1Lat) * sin(p2Lat) + cos(p1Lat) * cos(p2Lat) * cos(p2Lon-p1Lon)) * 6371;
}

+ (NSString *)makeUppercaseTrackedString:(NSString *)string {
    string = [string uppercaseString];
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[string length]];
    for (int i=0; i < [string length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        [characters addObject:ichar];
    }

    return [characters componentsJoinedByString:@" "];
}

@end
