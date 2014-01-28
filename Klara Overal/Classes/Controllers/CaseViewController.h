//
//  CaseViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseModel.h"
#import "CaseView.h"
#import "PlaylistTableViewController.h"

@interface CaseViewController : UIViewController

@property (nonatomic, strong) CaseView *view;
@property (nonatomic, strong) CaseModel *currentCase;
@property (nonatomic, strong) PlaylistTableViewController *playlistVC;

- (void)show;
- (void)hide;

@end
