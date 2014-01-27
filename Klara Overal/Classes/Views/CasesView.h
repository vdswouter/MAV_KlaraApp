//
//  PlaylistView.h
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 24/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistButton.h"
#import "CaseModel.h"

@interface CasesView : UIView

@property (nonatomic, strong) UIView *cases;
@property (nonatomic, strong) NSArray *caseButtons;

-(void) renderCases:(NSArray *)cases;

@end
