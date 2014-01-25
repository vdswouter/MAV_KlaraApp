//
//  AppViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Util.h"

#import "LivestreamViewController.h"
#import "PlaylistsViewController.h"
#import "ViewToggleButton.h"

@interface AppViewController : UIViewController

@property (strong, nonatomic) LivestreamViewController *livestreamVC;
@property (strong, nonatomic) PlaylistsViewController *playlistsVC;
@property (strong, nonatomic) ViewToggleButton *btnToggle;

@property (strong, nonatomic) UIViewController *currentVC;


@end
