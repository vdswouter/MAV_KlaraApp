//
//  QualityPicker.h
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 25/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "QualityPickerButton.h"

@interface QualityPicker : UIView

@property (nonatomic, strong) QualityPickerButton *btnLow;
@property (nonatomic, strong) QualityPickerButton *btnMid;
@property (nonatomic, strong) QualityPickerButton *btnHigh;
@property (nonatomic, strong) NSArray *buttons;

@property (nonatomic) NSInteger currentQuality;

@end
