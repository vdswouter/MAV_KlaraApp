//
//  PlaylistsViewController.m
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "CasesViewController.h"

@interface CasesViewController ()

@end

@implementation CasesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.caseVC = [[CaseViewController alloc] initWithNibName:nil bundle:nil];
        self.caseVC.playlistVC.delegate = self;
    }
    return self;
}

- (void)loadView {
//    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.view = [[CasesView alloc] initWithFrame:frame];
    
    [self.view addSubview:self.caseVC.view];
}

- (void)setCases:(NSArray *)cases {
    _cases = cases;
    [self.view renderCases:cases];

    for (uint i = 0; i < [self.view.caseButtons count]; i++) {
        PlaylistButton *btn = [self.view.caseButtons objectAtIndex:i];
        [btn addTarget:self action:@selector(caseSelected:) forControlEvents:UIControlEventTouchUpInside];
    }

    self.caseVC.currentCase = [self.cases objectAtIndex:0];
}

- (void)caseSelected:(UIButton *)btn {
    self.caseVC.currentCase = [self.cases objectAtIndex:(long) [btn tag]];
    [self.caseVC show];
}

- (void)playlistTableViewController:(PlaylistTableViewController *)playlistTableViewController changedCurrentItem:(NSInteger)index {
    NSMutableArray *playlist = [NSMutableArray arrayWithCapacity:[self.caseVC.currentCase.playlist count]];
    
    for (uint i = (uint)index; i < [self.caseVC.currentCase.playlist count]; i++) {
        PlaylistItemModel *model = (PlaylistItemModel *)[self.caseVC.currentCase.playlist objectAtIndex:i];
        [playlist addObject:[AVPlayerItem playerItemWithURL:model.file]];
    }
    
    for (uint j = 0; j < index; j++) {
        PlaylistItemModel *model = (PlaylistItemModel *)[self.caseVC.currentCase.playlist objectAtIndex:j];
        [playlist addObject:[AVPlayerItem playerItemWithURL:model.file]];
    }
    
    PlaylistItemModel *currentPlaylistItem = (PlaylistItemModel *)[self.caseVC.currentCase.playlist objectAtIndex:index];
    
    NSDictionary *streamInfo = @{
        MPMediaItemPropertyTitle: currentPlaylistItem.song,
        MPMediaItemPropertyArtist: currentPlaylistItem.artist,
        MPMediaItemPropertyAlbumTitle: @"Klara Overal",
    };
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:streamInfo];

    self.player = [AVQueuePlayer queuePlayerWithItems:[NSArray arrayWithArray:playlist]];
    [self.player play];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
