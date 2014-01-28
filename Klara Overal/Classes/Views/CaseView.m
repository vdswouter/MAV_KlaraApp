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

//        self.imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(48, 10, 112, 112)];
        self.imgIcon = [Util createImageFromPNG:@"case-onderweg" InDirectory:@"img" DoYouWantImageView:YES];
        self.imgIcon.frame = CGRectMake(104, 45, 112, 112);
        [self addSubview:self.imgIcon];

        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 175, 300, 45)];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor blackColor];
        self.lblTitle.font = [UIFont fontWithName:@"MetaSerifPro-Medi" size:29];
        self.lblTitle.text = @"Title placeholder";
        [self addSubview:self.lblTitle];

        self.lblSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 300, 45)];
        self.lblSubtitle.textAlignment = NSTextAlignmentCenter;
        self.lblSubtitle.textColor = [UIColor blackColor];
        self.lblSubtitle.font = [UIFont fontWithName:@"Calibre-Light" size:12];
        self.lblSubtitle.text = @"Subtitle placeholder";
        [self addSubview:self.lblSubtitle];

        self.btnClose = [[CloseButton alloc] initWithFrame:CGRectMake(300 - 44, 20, 44, 44)];
        [self addSubview:self.btnClose];
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
