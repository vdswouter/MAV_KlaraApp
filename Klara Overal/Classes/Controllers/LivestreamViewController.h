//
//  LivestreamViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveStreamView.h"
#import "QualityPicker.h"
#import "STKAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
@import MediaPlayer;

@interface LivestreamViewController : UIViewController
@property (nonatomic, strong) LiveStreamView *view;
@property (nonatomic, strong) QualityPicker *qualityPicker;
@property (nonatomic, strong) STKAudioPlayer *streamer;
@property (nonatomic, strong) NSDictionary *klaraStreamURLs;
@property (nonatomic, strong) NSString *currentAudioQuality;
@property (nonatomic) BOOL firstTime;

-(void)stopStream:(id)sender;


@end
