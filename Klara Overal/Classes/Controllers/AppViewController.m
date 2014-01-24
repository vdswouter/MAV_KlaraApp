//
//  AppViewController.m
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.livestreamVC = [[LivestreamViewController alloc] initWithNibName:nil bundle:nil];
        self.playlistsVC = [[PlaylistsViewController alloc] initWithNibName:nil bundle:nil];
    }

    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 4000)];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:self.livestreamVC.view];
    
    self.playlistsVC.view.frame = CGRectOffset(self.playlistsVC.view.frame, 0, CGRectGetHeight(self.livestreamVC.view.frame));
    [self.view addSubview:self.playlistsVC.view];
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
