//
//  PlaylistsViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CasesView.h"
#import "CaseViewController.h"
#import "PlaylistTableViewController.h"
@import AVFoundation;
@import MediaPlayer;

@interface CasesViewController : UIViewController <PlaylistTableViewControllerDelegate>

@property (nonatomic, strong) CasesView *view;
@property (nonatomic, strong) NSArray *cases;

@property (nonatomic, strong) AVQueuePlayer *player;

@property (nonatomic, strong) CaseViewController *caseVC;

@end
