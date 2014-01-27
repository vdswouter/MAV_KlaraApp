//
//  PlaylistButton.m
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "PlaylistButton.h"

@implementation PlaylistButton

- (id)initWithFrame:(CGRect)frame text:(NSString *)text andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    return self;
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
