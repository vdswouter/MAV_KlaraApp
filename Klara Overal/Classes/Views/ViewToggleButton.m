//
//  ViewToggleButton.m
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 24/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "ViewToggleButton.h"

@implementation ViewToggleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self toggleView:NO];
    }
    return self;
}

- (void)toggleView:(BOOL)upState{
    if (upState) {
        [self setImage:[Util createImageFromPNG:@"btnNaarLivestream" InDirectory:@"img" DoYouWantImageView:NO] forState:UIControlStateNormal];
        [self setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
    }else{
        [self setImage:[Util createImageFromPNG:@"btnAllePlaylists" InDirectory:@"img" DoYouWantImageView:NO] forState:UIControlStateNormal];
        [self setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
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
