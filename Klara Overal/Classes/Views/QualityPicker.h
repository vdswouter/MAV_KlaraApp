//
//  QualityPicker.h
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 25/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface QualityPicker : UIView

@property (nonatomic, strong) UIButton *btnLow;
@property (nonatomic, strong) UIButton *btnMid;
@property (nonatomic, strong) UIButton *btnHigh;
@property (nonatomic, strong) NSArray *buttons;

@end
