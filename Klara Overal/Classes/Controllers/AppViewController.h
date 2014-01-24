//
//  AppViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LivestreamViewController.h"
#import "PlaylistsViewController.h"

@interface AppViewController : UIViewController

@property (strong, nonatomic) LivestreamViewController *livestreamVC;
@property (strong, nonatomic) PlaylistsViewController *playlistsVC;

@property (strong, nonatomic) UIViewController *currentVC;

@end
