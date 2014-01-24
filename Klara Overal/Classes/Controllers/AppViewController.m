//
//  AppViewController.m
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()
//private properties
@property (nonatomic) int screenHeight;

@end

@implementation AppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    _screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);

    if (self) {
        self.livestreamVC = [[LivestreamViewController alloc] initWithNibName:nil bundle:nil];
        self.playlistsVC = [[PlaylistsViewController alloc] initWithNibName:nil bundle:nil];
        
        self.btnToggle = [[ViewToggleButton alloc] initWithFrame:CGRectMake(0, _screenHeight-44, 320, 44)];
        [self.btnToggle addTarget:self action:@selector(btnPressedHandler:) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, (_screenHeight*2)-44)];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:self.livestreamVC.view];
    [self.view addSubview:self.playlistsVC.view];
    
    [self.view addSubview:self.btnToggle];
    
    
    self.currentVC = self.livestreamVC;
}

- (void)btnPressedHandler:(id)sender{
    NSLog(@"[AppViewController] btn pressed");
    int newY;
    if (self.currentVC == self.livestreamVC) {
        newY = -(_screenHeight-66);
        [self.btnToggle toggleView:YES];
        
        self.currentVC = self.playlistsVC;
    }else{
        newY = 0;
        [self.btnToggle toggleView:NO];
        
        self.currentVC = self.livestreamVC;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, newY, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        //TODO: play pause the player/streamer
    }];
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
