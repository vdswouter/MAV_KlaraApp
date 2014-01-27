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
        // Custom initialization
    }
    return self;
}

- (id)initWithCase:(CaseModel *)newCase {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.currentCase = newCase;
    }

    return self;
}

- (void)loadView {
    self.view = [[CaseView alloc] initWithFrame:CGRectMake(320, 0, 320, 568)];
    
    [self.view.btnClose addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCurrentCase:(CaseModel *)newCase {
    _currentCase = newCase;

    self.view.lblTitle.text = self.currentCase.title;
    self.view.lblSubtitle.text = [self.currentCase.subtitle uppercaseString];
}

- (void)show {
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {}];

}

- (void)hide {
    CGRect frame = self.view.frame;
    frame.origin.x = 320;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {}];
    
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
