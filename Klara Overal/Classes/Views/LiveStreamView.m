//
//  LiveStreamView.m
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 24/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "LiveStreamView.h"

@interface LiveStreamView ()

@end

@implementation LiveStreamView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        BOOL cropView = (CGRectGetHeight(frame) < 568.0f);
        
        // Render the frequency info top bar
        UIImageView *frequencyInfo = [Util createImageFromPNG:@"frequencyInfo" InDirectory:@"img" DoYouWantImageView:YES];
        self.lblFrequency = [[UILabel alloc] initWithFrame:CGRectMake(257, 62, 50, 18)];
        self.lblFrequency.textColor = [UIColor colorWithWhite:100/255.0f alpha:1];
        self.lblFrequency.font = [UIFont fontWithName:@"Calibre-Semibold" size:13];
        [frequencyInfo addSubview:self.lblFrequency];
        [self addSubview:frequencyInfo];
        
        self.imgCurrentShow = [Util createImageFromPNG:@"klara-icon" InDirectory:@"img" DoYouWantImageView:YES];
        self.imgCurrentShow.contentMode = UIViewContentModeCenter;
        self.imgCurrentShow.frame = CGRectMake(105, CGRectGetMaxY(frequencyInfo.frame) + 37, 110, 110);
        self.imgCurrentShow.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgCurrentShow];
        
        // The info background is on top of the image so it acts as a circular mask
        UIImageView *nuOpKlara = [Util createImageFromPNG:@"nuOpKlara" InDirectory:@"img" DoYouWantImageView:YES];
        CGRect maskFrame = nuOpKlara.frame;
        maskFrame.origin.y = CGRectGetHeight(frequencyInfo.frame) + CGRectGetMinX(frequencyInfo.frame) + 15;
        nuOpKlara.frame = maskFrame;
        [self addSubview:nuOpKlara];
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 135, 220, 35)];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor blackColor];
        self.lblTitle.font = [UIFont fontWithName:@"MetaSerifPro-Medi" size:25];
        [nuOpKlara addSubview:self.lblTitle];
        
        self.lblPresenter = [[UILabel alloc] initWithFrame:CGRectMake(35, CGRectGetMinY(self.lblTitle.frame) + 45, 250, 20)];
        self.lblPresenter.textColor = [UIColor colorWithWhite:100/255.0f alpha:1];
        self.lblPresenter.textAlignment = NSTextAlignmentCenter;
        self.lblPresenter.font = [UIFont fontWithName:@"Calibre-Light" size:14];
        [nuOpKlara addSubview:self.lblPresenter];
        
        CGRect buttonFrame = CGRectMake(112, CGRectGetMaxY(maskFrame) + 5, 98, 90);
        
        if (!cropView) {
            buttonFrame.origin.y += 15;
        }

        self.btnPlayPause = [[PlayPauseButton alloc] initWithFrame:buttonFrame];
        [self addSubview:self.btnPlayPause];
        
        uint qualityPickerMarginTop = (cropView) ? 13 : 23;
        
        self.qualityPickerContainer = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.btnPlayPause.frame) + qualityPickerMarginTop, 288, 33)];
        self.qualityPickerContainer.clipsToBounds = YES;
        self.qualityPickerContainer.layer.borderWidth = 1;
        self.qualityPickerContainer.layer.borderColor = [[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.0f] CGColor];

        self.qualityPicker = [[UISegmentedControl alloc] initWithItems:@[@"", @"L A A G", @"M E D I U M", @"H O O G", @""]];
        [self.qualityPicker setBackgroundColor:[UIColor whiteColor]];
        self.qualityPicker.frame = CGRectMake(-11.0f, -8.0f, CGRectGetWidth(self.qualityPickerContainer.frame) + 25.0f, CGRectGetHeight(self.qualityPickerContainer.frame) + 20);
        [self.qualityPicker setWidth:10.0f forSegmentAtIndex:0];
        [self.qualityPicker setWidth:10.0f forSegmentAtIndex:4];
        [self.qualityPicker setTintColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.0f]];
        [self.qualityPicker setTitleTextAttributes:@{
            NSFontAttributeName: [UIFont fontWithName:@"Calibre-Light" size:12],
            NSForegroundColorAttributeName: [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.0f]
        } forState:UIControlStateNormal];
        
        [self.qualityPicker setTitleTextAttributes:@{
            NSForegroundColorAttributeName: [UIColor blackColor]
        } forState:UIControlStateHighlighted];
        
        [self.qualityPicker setTitleTextAttributes:@{
            NSForegroundColorAttributeName: [UIColor blackColor]
        } forState:UIControlStateSelected];

        self.qualityPicker.selectedSegmentIndex = 2;

        [self.qualityPickerContainer addSubview:self.qualityPicker];
        [self addSubview:self.qualityPickerContainer];
        
        [self hideQualityPicker];
    }
    return self;
}

- (void)updatePresenter:(NSString *)presenter {
    UIFont *lightFont = [UIFont fontWithName:@"Calibre-Light" size:16];
    NSDictionary *lightFontDict = [NSDictionary dictionaryWithObject: lightFont forKey:NSFontAttributeName];
    NSMutableAttributedString *lightAttrString = [[NSMutableAttributedString alloc] initWithString:@"Gepresenteerd door " attributes: lightFontDict];
    
    UIFont *heavyFont = [UIFont fontWithName:@"Calibre-Semibold" size:16];
    NSDictionary *heavyFontDict = [NSDictionary dictionaryWithObject:heavyFont forKey:NSFontAttributeName];
    NSMutableAttributedString *heavyFontAttrString = [[NSMutableAttributedString alloc]initWithString:presenter attributes:heavyFontDict];
    [lightAttrString appendAttributedString:heavyFontAttrString];
    
    self.lblPresenter.attributedText = lightAttrString;
}

- (void)showQualityPicker {
    if (self.frame.size.height < 568.0f) {
        CGRect buttonFrame = self.btnPlayPause.frame;
        buttonFrame.size.height = 35;
        
        [UIView animateWithDuration:0.330f animations:^(void) {
            self.btnPlayPause.frame = buttonFrame;
            self.qualityPickerContainer.frame = CGRectMake(16, CGRectGetMaxY(self.btnPlayPause.frame) + 17, 288, 33);
        }];
    }
}

- (void)hideQualityPicker {
    if (self.frame.size.height < 568.0f) {
    
        CGRect buttonFrame = self.btnPlayPause.frame;
        buttonFrame.size.height = 90;
    
        [UIView animateWithDuration:0.330f animations:^(void) {
            self.btnPlayPause.frame = buttonFrame;
            self.qualityPickerContainer.frame = CGRectMake(16, CGRectGetMaxY(self.btnPlayPause.frame) + 17 + 5, 288, 33);
        }];
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
