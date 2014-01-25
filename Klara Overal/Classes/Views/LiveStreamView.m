//
//  LiveStreamView.m
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 24/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "LiveStreamView.h"

@interface LiveStreamView ()

@property (nonatomic, strong) UILabel *lblFrequency;

@end

@implementation LiveStreamView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *frequencyInfo = [Util createImageFromPNG:@"frequencyInfo" InDirectory:@"img" DoYouWantImageView:YES];
        self.lblFrequency = [[UILabel alloc] initWithFrame:CGRectMake(235, 52, 50, 18)];
        self.lblFrequency.textColor = [UIColor colorWithWhite:100/255.0f alpha:1];
        self.lblFrequency.font = [UIFont fontWithName:@"Calibre-Semibold" size:13];
        [frequencyInfo addSubview:self.lblFrequency];
        [self addSubview:frequencyInfo];
        
        UIImageView *nuOpKlara = [Util createImageFromPNG:@"nuOpKlara" InDirectory:@"img" DoYouWantImageView:YES];
        nuOpKlara.frame = CGRectMake(16, 100, CGRectGetWidth(nuOpKlara.frame), CGRectGetHeight(nuOpKlara.frame));
        [self addSubview:nuOpKlara];
    }
    return self;
}

-(void)setLocalFrequency:(NSString *)localFrequency{
    _localFrequency = localFrequency;
    self.lblFrequency.text = localFrequency;
}

-(void)setProgramData:(ProgrammaModel *)programData{
    _programData = programData;
    
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
