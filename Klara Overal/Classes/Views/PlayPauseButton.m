//
//  PlayPauseButton.m
//  Klara Overal
//
//  Created by Pieter Beulque on 29/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "PlayPauseButton.h"

@implementation PlayPauseButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self.layer setBorderColor:[[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.0f]  CGColor]];
        [self.layer setBorderWidth:1];
        self.isPlaying = NO;
    }
    return self;
}

- (void)setIsPlaying:(BOOL)isPlaying {
    _isPlaying = isPlaying;
    
    NSString *imageName =  (self.isPlaying) ? @"pause" : @"play";
    NSLog(@"Set image playPause: %@", imageName);
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
