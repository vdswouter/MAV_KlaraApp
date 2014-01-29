//
//  CaseViewController.m
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "CaseViewController.h"

@interface CaseViewController ()

@end

@implementation CaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.playlistVC = [[PlaylistTableViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    return self;
}

- (id)initWithCase:(CaseModel *)newCase {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.currentCase = newCase;
    }

    return self;
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.x = frame.size.width;
    frame.origin.y = 0;

    self.view = [[CaseView alloc] initWithFrame:frame];
    
    [self.view.btnClose addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCurrentCase:(CaseModel *)newCase {
    _currentCase = newCase;
    
    self.playlistVC.playlistItems = self.currentCase.playlist;
    
    self.view.backgroundColor = self.currentCase.color;
    [self.view.imgIcon setImage:[Util createImageFromPNG:self.currentCase.cleanTitle InDirectory:@"img" DoYouWantImageView:NO]];
    self.view.lblTitle.text = self.currentCase.title;
    self.view.lblSubtitle.text = [Util makeUppercaseTrackedString:self.currentCase.subtitle];

    CGRect frame = CGRectMake(0, 240, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 240 - 50 - 24);
    self.playlistVC.view.frame = frame;

    [self.view addSubview:self.playlistVC.view];
    
}

- (void)show {
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = frame;
        [self.playlistVC.tableView reloadData];
    }];

}

- (void)hide {
    CGRect frame = self.view.frame;
    frame.origin.x = 320;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = frame;
    }];
    
}

@end
