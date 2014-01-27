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
    }
    return self;
}

- (void)loadView {
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
