//
//  NoInternetOverlayView.m
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 30/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "NoInternetOverlayView.h"

@implementation NoInternetOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        UIImageView *overlay = [Util createImageFromPNG:@"app-overlay" InDirectory:@"img" DoYouWantImageView:YES];
        overlay.frame = CGRectOffset(overlay.frame, 0, 22);
        [self addSubview:overlay];
        
        self.lblFrequency = [[UILabel alloc] initWithFrame:CGRectMake(235, 215, 50, 18)];
        self.lblFrequency.textColor = [UIColor colorWithWhite:100/255.0f alpha:1];
        self.lblFrequency.font = [UIFont fontWithName:@"Calibre-Semibold" size:13];
        [self addSubview:self.lblFrequency];
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [self.locationManager stopUpdatingLocation];
    
    double smallestDistance = 0;
    CLLocation *currentLocation = self.locationManager.location;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"frequencies" ofType:@"plist"];
    self.frequencies = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *antenna in self.frequencies) {
        double d = [Util CalculateDistanceBetween2PointsWithP1Lat:currentLocation.coordinate.latitude P1Lon:currentLocation.coordinate.longitude P2Lat:[[antenna objectForKey:@"latitude"] doubleValue] P2Lon:[[antenna objectForKey:@"longitude"] doubleValue]];
        
        if (smallestDistance == 0 || d < smallestDistance) {
            smallestDistance = d;
            self.lblFrequency.text = [[antenna objectForKey:@"frequency"] uppercaseString];
            break;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
