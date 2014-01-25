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
@property (nonatomic, strong) UILabel *lblPresenter;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDescription;

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
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 227, 230, 35)];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor blackColor];
        self.lblTitle.font = [UIFont fontWithName:@"MetaSerifPro-Medi" size:23];
        [self addSubview:self.lblTitle];
        
        self.lblPresenter = [[UILabel alloc] initWithFrame:CGRectMake(50, 276, 230, 20)];
        self.lblPresenter.textColor = [UIColor colorWithWhite:100/255.0f alpha:1];
        self.lblPresenter.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lblPresenter];
        
        self.lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(70, 284, 190, 50)];
        self.lblDescription.textAlignment = NSTextAlignmentCenter;
        self.lblDescription.numberOfLines = 2;
        self.lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
        self.lblDescription.textColor = [UIColor colorWithWhite:100/255.0f alpha:1];
        self.lblDescription.font = [UIFont fontWithName:@"Calibre-Light" size:11];
        [self addSubview:self.lblDescription];
    }
    return self;
}

-(void)setLocalFrequency:(NSString *)localFrequency{
    _localFrequency = localFrequency;
    self.lblFrequency.text = localFrequency;
}

-(void)setProgramData:(ProgrammaModel *)programData{
    _programData = programData;
    
    UIFont *lightFont = [UIFont fontWithName:@"Calibre-Light" size:11];
    NSDictionary *lightFontDict = [NSDictionary dictionaryWithObject: lightFont forKey:NSFontAttributeName];
    NSMutableAttributedString *lightAttrString = [[NSMutableAttributedString alloc] initWithString:@"Gepresenteerd door " attributes: lightFontDict];
    
    UIFont *heavyFont = [UIFont fontWithName:@"Calibre-Semibold" size:11];
    NSDictionary *heavyFontDict = [NSDictionary dictionaryWithObject:heavyFont forKey:NSFontAttributeName];
    NSMutableAttributedString *heavyFontAttrString = [[NSMutableAttributedString alloc]initWithString: programData.presenter attributes:heavyFontDict];
    [lightAttrString appendAttributedString:heavyFontAttrString];
    
    self.lblPresenter.attributedText = lightAttrString;
    
    self.lblTitle.text = programData.title;
    self.lblDescription.text = programData.info;
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
