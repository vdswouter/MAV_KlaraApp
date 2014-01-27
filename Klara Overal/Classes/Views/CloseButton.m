//
//  CloseButton.m
//  Klara Overal
//
//  Created by Pieter Beulque on 28/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "CloseButton.h"

@implementation CloseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[Util createImageFromPNG:@"btn-close" InDirectory:@"img" DoYouWantImageView:NO] forState:UIControlStateNormal];
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
