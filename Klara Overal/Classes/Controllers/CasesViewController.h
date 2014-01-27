//
//  PlaylistsViewController.h
//  Klara Overal
//
//  Created by Pieter Beulque on 18/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CasesView.h"
#import "CaseViewController.h"

@interface CasesViewController : UIViewController

@property (nonatomic, strong) CasesView *view;
@property (nonatomic, strong) NSArray *cases;

@property (nonatomic, strong) CaseViewController *caseVC;

@end
