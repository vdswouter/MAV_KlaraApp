//
//  QualityPicker.m
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 25/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "QualityPicker.h"

@implementation QualityPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnLow = [[QualityPickerButton alloc] initWithQuality:0 andTitle:@"L A A G"];
        self.btnMid = [[QualityPickerButton alloc] initWithQuality:1 andTitle:@"M E D I U M"];
        self.btnHigh = [[QualityPickerButton alloc] initWithQuality:2 andTitle:@"H O O G"];
        
        self.buttons = @[self.btnLow, self.btnMid, self.btnHigh];

        CGRect frameMid = self.btnMid.frame;
        frameMid.origin.x = 94;
        self.btnMid.frame = frameMid;
        
        CGRect frameHigh = self.btnHigh.frame;
        frameHigh.origin.x = 188;
        self.btnHigh.frame = frameHigh;
        
        for (QualityPickerButton *btn in self.buttons) {
            [self addSubview:btn];
            [btn addTarget:self action:@selector(changeQuality:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)changeQuality:(QualityPickerButton *)sender {
    self.currentQuality = sender.tag;
    
//    if (sender == self.btnHigh) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"QUALITY_CHANGED" object:self userInfo:@{ @"quality": @"HIGH" }];
//    }
//    if (sender == self.btnMid) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"QUALITY_CHANGED" object:self userInfo:@{ @"quality": @"MID" }];
//    }
//    if (sender == self.btnLow) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"QUALITY_CHANGED" object:self userInfo:@{ @"quality": @"LOW" }];
//    }
}

- (void)setCurrentQuality:(NSInteger)currentQuality {
    _currentQuality = currentQuality;

    for (QualityPickerButton *btn in self.buttons) {
        btn.isActive = (btn.tag == currentQuality);
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
