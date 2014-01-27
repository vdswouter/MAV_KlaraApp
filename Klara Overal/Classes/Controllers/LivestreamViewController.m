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
        self.firstTime = YES;
        
        self.klaraStreamURLs = [[NSDictionary alloc] initWithObjectsAndKeys:@"http://mp3.streampower.be/klara-high.mp3",@"HIGH",@"http://mp3.streampower.be/klara-mid.mp3",@"MID",@"http://mp3.streampower.be/klara-low.mp3",@"LOW",nil];

        self.streamer = [[STKAudioPlayer alloc] init];
    }
    return self;
}

- (void)loadView {
    self.view = [[LiveStreamView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view.btnPlay addTarget:self action:@selector(startStream:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnPause addTarget:self action:@selector(stopStream:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect qualityPickerFrame;
    if ([self hasFourInchDisplay]) {
        qualityPickerFrame = CGRectMake(17, 467, 285, 34);
    }else{
        qualityPickerFrame = CGRectMake(17, 440, 285, 34);
    }
    self.qualityPicker = [[QualityPicker alloc] initWithFrame:qualityPickerFrame];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qualityChangedHandler:) name:@"QUALITY_CHANGED" object:self.qualityPicker];
    [self.view addSubview:self.qualityPicker];
}

-(void)qualityChangedHandler:(NSNotification *)sender{
    [self.streamer stop];
    self.currentAudioQuality = [[sender userInfo] objectForKey:@"quality"];
    [self.streamer play:[self.klaraStreamURLs objectForKey:self.currentAudioQuality]];
}

-(void)startStream:(id)sender{
    self.view.btnPlay.userInteractionEnabled = NO;
    self.view.btnPause.userInteractionEnabled = YES;
    [self.streamer play:[self.klaraStreamURLs objectForKey:self.currentAudioQuality]];
    [UIView animateWithDuration:0.3 animations:^{
        if (![self hasFourInchDisplay]) {
            self.qualityPicker.frame = CGRectMake(17, 386, 285, 34);
            self.view.btnPlay.frame = CGRectMake(CGRectGetMinX(self.view.btnPlay.frame), CGRectGetMinY(self.view.btnPlay.frame), 90, 40);
            self.view.btnPause.frame = CGRectMake(CGRectGetMinX(self.view.btnPause.frame), CGRectGetMinY(self.view.btnPause.frame), 90, 40);
        }
        if (self.firstTime) {
            self.qualityPicker.btnMid.titleLabel.textColor = [UIColor whiteColor];
            self.qualityPicker.btnMid.backgroundColor = [UIColor blackColor];
            self.qualityPicker.btnMid.userInteractionEnabled = false;
            self.firstTime = NO;
        }
    }];
}

-(void)stopStream:(id)sender{
    self.view.btnPause.userInteractionEnabled = NO;
    self.view.btnPlay.userInteractionEnabled = YES;
    [self.streamer stop];
    if (![self hasFourInchDisplay]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.qualityPicker.frame = CGRectMake(17, 440, 285, 34);
            self.view.btnPlay.frame = CGRectMake(CGRectGetMinX(self.view.btnPlay.frame), CGRectGetMinY(self.view.btnPlay.frame), 90, 90);
            self.view.btnPause.frame = CGRectMake(CGRectGetMinX(self.view.btnPause.frame), CGRectGetMinY(self.view.btnPause.frame), 90, 90);
        }];
    }
}

- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
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
