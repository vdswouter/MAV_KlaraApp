//
//  PlaylistButton.m
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "PlaylistButton.h"

@implementation PlaylistButton

- (id)initWithFrame:(CGRect)frame text:(NSString *)text backgroundColor:(UIColor *)backgroundColor andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = backgroundColor;
//
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"Calibre-Light" size:14];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];

//        self.userInteractionEnabled = YES;

//        const char *c = [[text uppercaseString] UTF8String];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitle:[text uppercaseString] forState:UIControlStateNormal];
        
        [self setTitleEdgeInsets:UIEdgeInsetsMake(20.0f, 10.0f, 0.0f, 10.0f)];
        
        UIView *testCircle = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame) * .5 - 6, CGRectGetHeight(frame) - 26, 12, 12)];
        testCircle.backgroundColor = color;
        testCircle.layer.cornerRadius = 6.0f;
        [self addSubview:testCircle];
    }
    return self;
}


@end
