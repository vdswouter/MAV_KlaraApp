//
//  NoInternetOverlayView.h
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 30/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Util.h"

@interface NoInternetOverlayView : UIButton<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *frequencies;
@property (nonatomic, strong) UILabel *lblFrequency;

@end
