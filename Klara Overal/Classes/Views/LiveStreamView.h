//
//  LiveStreamView.h
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 24/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

#import "ProgrammaModel.h"
#import "PlaylistButton.h"
#import "PlayPauseButton.h"

@interface LiveStreamView : UIView

@property (nonatomic, strong) UIImageView *imgCurrentShow;
@property (nonatomic, strong) UILabel *lblFrequency;
@property (nonatomic, strong) UILabel *lblPresenter;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDescription;
@property (nonatomic, strong) PlayPauseButton *btnPlayPause;

@property (nonatomic, strong) UISegmentedControl *qualityPicker;

- (void)updatePresenter:(NSString *)presenter;

@end
