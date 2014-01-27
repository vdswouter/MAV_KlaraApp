//
//  PlaylistView.m
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 24/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "PlaylistView.h"

@implementation PlaylistView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 45)];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.textColor = [UIColor blackColor];
        lblTitle.font = [UIFont fontWithName:@"MetaSerifPro-Medi" size:29];
        lblTitle.text = @"Playlists";
        [self addSubview:lblTitle];
        
        UILabel *lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(30, 45, 260, 100)];
        lblDescription.textAlignment = NSTextAlignmentCenter;
        lblDescription.numberOfLines = 3;
        lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
        lblDescription.textColor = [UIColor blackColor];
        lblDescription.font = [UIFont fontWithName:@"Calibre-Light" size:14];
        lblDescription.text = @"Een kleine selectie uit het aanbod van Klara, afgestemd op verschillende situaties in het dagdagelijkse leven.";
        [self addSubview:lblDescription];

        PlaylistButton *btnTest = [[PlaylistButton alloc] initWithFrame:CGRectMake(0, 145, 320, 40) text:@"test" andColor:[UIColor greenColor]];
        [self addSubview:btnTest];

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
