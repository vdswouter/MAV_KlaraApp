//
//  PlaylistView.m
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 24/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "CasesView.h"

@implementation CasesView

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
        
        UILabel *lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(30, 45, 260, 80)];
        lblDescription.textAlignment = NSTextAlignmentCenter;
        lblDescription.numberOfLines = 3;
        lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
        lblDescription.textColor = [UIColor blackColor];
        lblDescription.font = [UIFont fontWithName:@"Calibre-Light" size:14];
        lblDescription.text = @"Een kleine selectie uit het aanbod van Klara, afgestemd op verschillende situaties in het dagdagelijkse leven.";
        [self addSubview:lblDescription];
        
        // @todo - Fix height
        
        self.cases = [[UIView alloc] initWithFrame:CGRectMake(0, 125, 320, 423)];
        [self addSubview:self.cases];
    }

    return self;
}

-(void) renderCases:(NSArray *)cases {
    uint yPos = 0;
    uint height = 72;

    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:[cases count]];

    for (uint i = 0; i < [cases count]; i++) {
        UIColor *bgColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:((i % 2) ? 1.0f : 0.94f) alpha:1.0f];
        CaseModel *currentCase = [cases objectAtIndex:i];
        PlaylistButton *btn = [[PlaylistButton alloc] initWithFrame:CGRectMake(0, yPos, 320, height) text:currentCase.title backgroundColor:bgColor andColor:[UIColor blackColor]];
        [btn setTag:i];
        yPos += height;
        [self.cases addSubview:btn];
        [buttons addObject:btn];
    }
    
    self.caseButtons = [NSArray arrayWithArray:buttons];
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
