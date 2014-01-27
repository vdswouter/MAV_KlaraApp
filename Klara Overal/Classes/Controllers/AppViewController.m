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
        
        [self loadData];
    }

    return self;
}

- (void)loadData{
    //loading de programmadata.
    NSURL *URL = [NSURL URLWithString:@"http://services.vrt.be/epg/onair?channel_code=31&accept=application%2Fvnd.epg.vrt.be.onairs_1.0%2Bjson"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id nowNode = [[[responseObject objectForKey:@"onairs"] objectAtIndex:0] objectForKey:@"now"];
        self.huidigProgrammaData = [[ProgrammaModel alloc] init];
        if ([nowNode count] > 0) {
            self.huidigProgrammaData.title = [nowNode objectForKey:@"title"];
            self.huidigProgrammaData.info = [nowNode objectForKey:@"shortDescription"];
            self.huidigProgrammaData.imgURL = [nowNode objectForKey:@"pictureUrl"];
            self.huidigProgrammaData.presenter = [[[nowNode objectForKey:@"presenters"] objectAtIndex:0] objectForKey:@"name"];
        }
        self.livestreamVC.view.programData = self.huidigProgrammaData;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    
}

- (void)loadView {
    self.livestreamVC = [[LivestreamViewController alloc] initWithNibName:nil bundle:nil];
    self.playlistsVC = [[PlaylistsViewController alloc] initWithNibName:nil bundle:nil];
    
    self.btnToggle = [[ViewToggleButton alloc] initWithFrame:CGRectMake(0, _screenHeight-44, 320, 44)];
    [self.btnToggle addTarget:self action:@selector(btnPressedHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, (_screenHeight*2)-44)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.livestreamVC.view];
    [self.view addSubview:self.playlistsVC.view];
    
    [self.view addSubview:self.btnToggle];
    
    
    self.currentVC = self.livestreamVC;
}

- (void)btnPressedHandler:(id)sender{
    NSLog(@"[AppViewController] btn pressed");
    int newY;
    UIView *oldView = self.currentVC.view;
    if (self.currentVC == self.livestreamVC) {
        newY = -(_screenHeight-66);
        [self.btnToggle toggleView:YES];
        [self.livestreamVC stopStream:nil];
        self.playlistsVC.view.alpha = 1;
        self.currentVC = self.playlistsVC;
    }else{
        newY = 0;
        [self.btnToggle toggleView:NO];
        self.livestreamVC.view.alpha = 1;
        self.currentVC = self.livestreamVC;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, newY, self.view.frame.size.width, self.view.frame.size.height);
        oldView.alpha = 0;
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
