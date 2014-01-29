//
//  PlaylistTableViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 28/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistItemModel.h"
#import "PlaylistTableViewCell.h"

@class PlaylistTableViewController;

@protocol PlaylistTableViewControllerDelegate <NSObject>

- (void)playlistTableViewController:(PlaylistTableViewController *)playlistTableViewController changedCurrentItem:(NSInteger)index;

@end

@interface PlaylistTableViewController : UITableViewController

@property (weak, nonatomic) id<PlaylistTableViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *playlistItems;

@end
