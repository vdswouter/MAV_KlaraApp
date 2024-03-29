//
//  LivestreamViewController.m
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "LivestreamViewController.h"

@interface LivestreamViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *frequencies;

@end

@implementation LivestreamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.currentAudioQuality = @"MID";
        self.isStreaming = NO;

        self.klaraStreamURLs = @{
            @"LOW": @"http://mp3.streampower.be/klara-low.mp3",
            @"MID": @"http://mp3.streampower.be/klara-mid.mp3",
            @"HIGH": @"http://mp3.streampower.be/klara-high.mp3"
        };

        self.streamer = [[STKAudioPlayer alloc] init];
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (void)loadView {
    self.view = [[LiveStreamView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view.btnPlayPause addTarget:self action:@selector(toggleStream) forControlEvents:UIControlEventTouchUpInside];
    [self.view.qualityPicker addTarget:self action:@selector(qualityChangedHandler:) forControlEvents:UIControlEventValueChanged];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [self.locationManager stopUpdatingLocation];

    double smallestDistance = 0;
    CLLocation *currentLocation = self.locationManager.location;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"frequencies" ofType:@"plist"];
    self.frequencies = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *antenna in self.frequencies) {
        double d = [Util CalculateDistanceBetween2PointsWithP1Lat:currentLocation.coordinate.latitude P1Lon:currentLocation.coordinate.longitude P2Lat:[[antenna objectForKey:@"latitude"] doubleValue] P2Lon:[[antenna objectForKey:@"longitude"] doubleValue]];

        if (smallestDistance == 0 || d < smallestDistance) {
            smallestDistance = d;
            self.view.lblFrequency.text = [[antenna objectForKey:@"frequency"] uppercaseString];
        }
    }
}

- (void)qualityChangedHandler:(UISegmentedControl *)qualityPicker {
    NSArray *qualities = @[@"LOW", @"MID", @"HIGH"];
    self.currentAudioQuality = [qualities objectAtIndex:(self.view.qualityPicker.selectedSegmentIndex - 1)];
}

- (void)setCurrentAudioQuality:(NSString *)currentAudioQuality {
    _currentAudioQuality = currentAudioQuality;

    NSLog(@"quality changed: %@", _currentAudioQuality);

    if (self.isStreaming) {
        [self.streamer stop];
        [self.streamer play:[self.klaraStreamURLs objectForKey:self.currentAudioQuality]];
        NSLog(@"Restarting streamer - %@", [self.klaraStreamURLs objectForKey:self.currentAudioQuality]);
    }
}

- (void)toggleStream {
    if (self.isStreaming) {
        [self stopStream];
    } else {
        [self startStream];
    }
}

- (void)startStream {
    self.view.btnPlayPause.isPlaying = self.isStreaming = YES;
    [self.streamer play:[self.klaraStreamURLs objectForKey:self.currentAudioQuality]];
    
    [self.view showQualityPicker];
    
    NSLog(@"Start stream - %@", [self.klaraStreamURLs objectForKey:self.currentAudioQuality]);

    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:[Util createImageFromPNG:@"album-cover-white" InDirectory:@"img" DoYouWantImageView:NO]];
    
    NSDictionary *streamInfo = @{
        MPMediaItemPropertyTitle: @"Klara Overal Livestream",
        MPMediaItemPropertyArtist: @"Klara",
        MPMediaItemPropertyAlbumTitle: @"Klara Overal",
        MPMediaItemPropertyAlbumArtist: @"Klara",
        MPMediaItemPropertyArtwork: artwork
    };

    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:streamInfo];
}

- (void)stopStream {
    self.view.btnPlayPause.isPlaying = self.isStreaming = NO;
    [self.streamer stop];
    [self.view hideQualityPicker];
    
    NSLog(@"Stop stream");
}

- (void)setCurrentShow:(ProgrammaModel *)currentShow {
    _currentShow = currentShow;
    
    self.view.lblTitle.text = self.currentShow.title;
    [self.view updatePresenter:self.currentShow.presenter];

    if ([self.currentShow.imgURL length] > 0) {
        NSMutableArray *urlPieces = [NSMutableArray arrayWithArray:[self.currentShow.imgURL componentsSeparatedByString:@"/"]];
        [urlPieces setObject:[NSString stringWithFormat:@"10_%@",[urlPieces lastObject]] atIndexedSubscript:[urlPieces count]-1];
        self.currentShow.imgURL = [urlPieces componentsJoinedByString:@"/"];
        NSLog(@"the image URL = %@",self.currentShow.imgURL);
        
        UIImage *presenterImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.currentShow.imgURL]]];
        if (presenterImg.size.width > 70) {
            self.view.imgCurrentShow.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.currentShow.imgURL]]];
            self.view.imgCurrentShow.contentMode = UIViewContentModeScaleAspectFill;
            self.view.presenterImage = YES;
        }
    }

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
