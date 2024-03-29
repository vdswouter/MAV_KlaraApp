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
    

    if (self) {
        _screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);

        self.livestreamVC = [[LivestreamViewController alloc] initWithNibName:nil bundle:nil];
        self.casesVC = [[CasesViewController alloc] initWithNibName:nil bundle:nil];
        
        self.currentVC = self.livestreamVC;
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
        ProgrammaModel *currentShow = [[ProgrammaModel alloc] init];

        if ([nowNode count] > 0) {
            currentShow.title = [nowNode objectForKey:@"title"];
            currentShow.info = [nowNode objectForKey:@"shortDescription"];
            currentShow.imgURL = [nowNode objectForKey:@"pictureUrl"];
//            currentShow.imgURL = @"http://radio.klara.be/radio/images/pres_fotos/LAE.jpg";
            currentShow.presenter = [[[nowNode objectForKey:@"presenters"] objectAtIndex:0] objectForKey:@"name"];
        }
        
        self.livestreamVC.currentShow = currentShow;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    
    // Load cases
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://student.howest.be/pieter.beulque/20132014/mav/data/cases.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id res) {
        NSArray *jsonCases = [res objectForKey:@"cases"];
        NSMutableArray *cases = [NSMutableArray arrayWithCapacity:[jsonCases count]];
        
        for (uint i = 0; i < [jsonCases count]; i++) {
            [cases addObject:[CaseModel createFromJSON:[jsonCases objectAtIndex:i]]];
        }
        
        self.casesVC.cases = [NSArray arrayWithArray:cases];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, _screenHeight)];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.appView = [[AppView alloc] initWithFrame:CGRectMake(0, 0, 320, _screenHeight * 2 - 50)];
    [self.view addSubview:self.appView];
}

- (void)toggleViews:(UIButton *)button {
    CGRect newFrame = self.appView.frame;
    
    self.btnToggle.isViewToggled = (self.currentVC == self.livestreamVC);
    
    newFrame.origin.y = (self.btnToggle.isViewToggled) ? -1 * (_screenHeight - 72) : 0;

    [UIView animateWithDuration:0.440f animations:^{
        self.appView.frame = newFrame;
        self.currentVC.view.alpha = 0;
    }];

    self.currentVC = (self.btnToggle.isViewToggled) ? self.casesVC : self.livestreamVC;
    self.currentVC.view.alpha = 1;
    
    if (self.btnToggle.isViewToggled) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        [self.livestreamVC stopStream];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        [self.casesVC stopAudio];
    }
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
                
            case UIEventSubtypeRemoteControlPause:
                if (self.btnToggle.isViewToggled) {
                    [self.casesVC stopAudio];
                }else{
                    [self.livestreamVC stopStream];
                }
                break;
                
            case UIEventSubtypeRemoteControlPlay:
                if (self.btnToggle.isViewToggled) {
                    [self.casesVC startAudio];
                }else{
                    [self.livestreamVC startStream];
                }
                break;
                
            default: break;
        }
    }
}

-(void)recheckConnection:(id)sender{
    if ([Util networkConnectionAvailable]) {
        [self loadData];
        [UIView animateWithDuration:0.440f animations:^{
            self.overlay.alpha = 0;
        } completion:^(BOOL finished) {
            [self.overlay removeFromSuperview];
            self.overlay = nil;
        }];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.btnToggle = [[ViewToggleButton alloc] initWithFrame:CGRectMake(0, _screenHeight - 50, 320, 50)];
    [self.btnToggle addTarget:self action:@selector(toggleViews:) forControlEvents:UIControlEventTouchUpInside];

    [self.appView addSubview:self.livestreamVC.view];
    [self.appView addSubview:self.casesVC.view];
    
    [self.appView addSubview:self.btnToggle];
    
    if ([Util networkConnectionAvailable]) {
        [self loadData];
    }else{
        self.overlay = [[NoInternetOverlayView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.overlay addTarget:self action:@selector(recheckConnection:) forControlEvents:UIControlEventTouchUpInside];
        [self.appView addSubview:self.overlay];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
