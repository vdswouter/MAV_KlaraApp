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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Netwerk probleem" message:@"Er is geen werkende internetverbinding aanwezig. Zet 3G aan of verbind met een WIFI netwerk." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
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

@end
