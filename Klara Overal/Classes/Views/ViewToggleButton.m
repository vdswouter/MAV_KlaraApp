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
        self.isViewToggled = NO;
    }
    return self;
}

- (void)setIsViewToggled:(BOOL)isViewToggled {
    _isViewToggled = isViewToggled;
    NSString *imageName = isViewToggled ? @"btnNaarLivestream" : @"btnAllePlaylists";
    [self setImage:[Util createImageFromPNG:imageName InDirectory:@"img" DoYouWantImageView:NO] forState:UIControlStateNormal];
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
