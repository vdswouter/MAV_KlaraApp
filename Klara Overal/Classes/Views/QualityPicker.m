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
        // Initialization code
        self.btnLow = [[UIButton alloc] initWithFrame:CGRectMake(1, 0, 95, 34)];
        self.btnMid = [[UIButton alloc] initWithFrame:CGRectMake(95, 0, 95, 34)];
        self.btnHigh = [[UIButton alloc] initWithFrame:CGRectMake(189, 0, 95, 34)];

        [self.btnLow setTitle:@"LAAG" forState:UIControlStateNormal];
        [self.btnMid setTitle:@"MEDIUM" forState:UIControlStateNormal];
        [self.btnHigh setTitle:@"HOOG" forState:UIControlStateNormal];
                
        [self.btnHigh.layer setBorderWidth:1];
        [self.btnHigh.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [self.btnMid.layer setBorderWidth:1];
        [self.btnMid.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [self.btnLow.layer setBorderWidth:1];
        [self.btnLow.layer setBorderColor:[[UIColor blackColor] CGColor]];
        
        [self addSubview:self.btnLow];
        [self addSubview:self.btnMid];
        [self addSubview:self.btnHigh];
        
        self.buttons = [[NSArray alloc] initWithObjects:self.btnLow,self.btnMid,self.btnHigh, nil];
        
        for (UIButton *btn in self.buttons) {
            btn.titleLabel.font = [UIFont fontWithName:@"Calibre-Light" size:11];
            btn.titleLabel.textColor = [UIColor blackColor];
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(touchHandler:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

-(void)touchHandler:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        for (UIButton *btn in self.buttons) {
            if (btn == sender) {
                btn.titleLabel.textColor = [UIColor whiteColor];
                btn.backgroundColor = [UIColor blackColor];
                btn.userInteractionEnabled = false;
            }else{
                btn.titleLabel.textColor = [UIColor blackColor];
                btn.backgroundColor = [UIColor clearColor];
                btn.userInteractionEnabled = true;
            }
        }
    }];
    if (sender == self.btnHigh) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QUALITY_CHANGED" object:self userInfo:@{ @"quality": @"HIGH" }];
    }
    if (sender == self.btnMid) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QUALITY_CHANGED" object:self userInfo:@{ @"quality": @"MID" }];
    }
    if (sender == self.btnLow) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QUALITY_CHANGED" object:self userInfo:@{ @"quality": @"LOW" }];
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
