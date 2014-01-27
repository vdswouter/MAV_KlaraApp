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
        self.backgroundColor = [UIColor redColor];

        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 45)];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor blackColor];
        self.lblTitle.font = [UIFont fontWithName:@"MetaSerifPro-Medi" size:29];
        self.lblTitle.text = @"Title placeholder";
        [self addSubview:self.lblTitle];

        self.lblSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 300, 45)];
        self.lblSubtitle.textAlignment = NSTextAlignmentCenter;
        self.lblSubtitle.textColor = [UIColor blackColor];
        self.lblSubtitle.font = [UIFont fontWithName:@"Calibre-Light" size:14];
        self.lblSubtitle.text = @"Subtitle placeholder";
        [self addSubview:self.lblSubtitle];
        
        self.btnClose = [[CloseButton alloc] initWithFrame:CGRectMake(300 - 24, 20, 24, 24)];
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
