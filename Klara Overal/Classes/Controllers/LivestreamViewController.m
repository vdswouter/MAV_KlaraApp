//
//  LivestreamViewController.m
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "LivestreamViewController.h"

@interface LivestreamViewController ()

@end

@implementation LivestreamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.currentAudioQuality = @"MID";
        
        self.klaraStreamURLs = [[NSDictionary alloc] initWithObjectsAndKeys:@"http://mp3.streampower.be/klara-high.mp3",@"hoog",@"http://mp3.streampower.be/klara-mid.mp3",@"MID",@"http://mp3.streampower.be/klara-low.mp3",@"LOW",nil];

        self.streamer = [[STKAudioPlayer alloc] init];
//        self.streamer.delegate = self;
    }
    return self;
}

- (void)loadView {
    self.view = [[LiveStreamView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view.btnPlay addTarget:self action:@selector(StartStream:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnPause addTarget:self action:@selector(StopStream:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)StartStream:(id)sender{
    [self.streamer play:[self.klaraStreamURLs objectForKey:self.currentAudioQuality]];
}

-(void)StopStream:(id)sender{
    [self.streamer stop];
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
