//
//  QualityPickerButton.m
//  Klara Overal
//
//  Created by Pieter Beulque on 29/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "QualityPickerButton.h"

@implementation QualityPickerButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithQuality:(NSInteger)quality andTitle:(NSString *)title {
    self = [super initWithFrame:CGRectMake(0, 0, 95, 34)];
    
    if (self) {
        [self.layer setBorderWidth:1];
        [self.layer setBorderColor:[[UIColor colorWithWhite:220/255.0f alpha:1] CGColor]];
        
        [self setTag:quality];
        
        [self setTitleEdgeInsets:UIEdgeInsetsMake(6, 0, 0, 0)];
        self.titleLabel.font = [UIFont fontWithName:@"Calibre-Light" size:14];
        self.titleLabel.textColor = [UIColor blackColor];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateDisabled];
        NSLog(@"%u", self.state);

        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = true;
    }

    return self;
}

- (void)setIsActive:(BOOL)isActive {
    _isActive = isActive;
    
    if (self.isActive) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
        [self.layer setBorderColor:[[UIColor blackColor] CGColor]];
        self.userInteractionEnabled = false;
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        [self.layer setBorderColor:[[UIColor colorWithWhite:220/255.0f alpha:1] CGColor]];
        self.userInteractionEnabled = true;
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
