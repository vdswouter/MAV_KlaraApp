//
//  LivestreamViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveStreamView.h"
#import "STKAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ProgrammaModel.h"
@import MediaPlayer;

@interface LivestreamViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic, strong) LiveStreamView *view;

@property (nonatomic, strong) NSString *currentAudioQuality;

@property (nonatomic, strong) STKAudioPlayer *streamer;
@property (nonatomic, strong) NSDictionary *klaraStreamURLs;

@property (nonatomic, strong) ProgrammaModel *currentShow;
@property (nonatomic) BOOL isStreaming;

- (void)startStream;
- (void)stopStream;

@end
