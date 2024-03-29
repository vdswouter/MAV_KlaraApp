//
//  AppViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"

#import "AFNetworking.h"

#import "LivestreamViewController.h"
#import "CasesViewController.h"
#import "ViewToggleButton.h"
#import "ProgrammaModel.h"
#import "CaseModel.h"
#import "AppView.h"
#import "NoInternetOverlayView.h"
@import AVFoundation;

@interface AppViewController : UIViewController

@property (strong, nonatomic) AppView *appView;

@property (strong, nonatomic) LivestreamViewController *livestreamVC;
@property (strong, nonatomic) CasesViewController *casesVC;
@property (strong, nonatomic) ViewToggleButton *btnToggle;
@property (strong,nonatomic) NoInternetOverlayView *overlay;

@property (strong, nonatomic) UIViewController *currentVC;

@property AVPlayer *audioPlayer;

@end
