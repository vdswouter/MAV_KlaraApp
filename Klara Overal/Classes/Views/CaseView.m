//
//  CaseView.m
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "CaseView.h"

@implementation CaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.863f green:0.898f blue:0.643f alpha:1.0f];

        UIView *infoContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 240)];
        infoContainer.backgroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:0.3f];
        [self addSubview:infoContainer];
        
//        self.imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(48, 10, 112, 112)];
        self.imgIcon = [Util createImageFromPNG:@"case-onderweg" InDirectory:@"img" DoYouWantImageView:YES];
        self.imgIcon.frame = CGRectMake(104, 30, 112, 112);
        [infoContainer addSubview:self.imgIcon];

        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 300, 45)];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor blackColor];
        self.lblTitle.font = [UIFont fontWithName:@"MetaSerifPro-Medi" size:29];
        self.lblTitle.text = @"Title placeholder";
        [infoContainer addSubview:self.lblTitle];

        self.lblSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, 300, 45)];
        self.lblSubtitle.textAlignment = NSTextAlignmentCenter;
        self.lblSubtitle.textColor = [UIColor blackColor];
        self.lblSubtitle.font = [UIFont fontWithName:@"Calibre-Light" size:12];
        self.lblSubtitle.text = @"Subtitle placeholder";
        [infoContainer addSubview:self.lblSubtitle];

        self.btnClose = [[CloseButton alloc] initWithFrame:CGRectMake(300 - 44, 20, 44, 44)];
        [infoContainer addSubview:self.btnClose];
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
