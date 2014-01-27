//
//  LiveStreamView.h
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 24/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

#import "ProgrammaModel.h"
#import "PlaylistButton.h"
@interface LiveStreamView : UIView

@property (nonatomic, strong) NSString *localFrequency;
@property (nonatomic, strong) ProgrammaModel *programData;
@property (nonatomic, strong) UIButton *btnPlay;
@property (nonatomic, strong) UIButton *btnPause;

-(void)setLocalFrequency:(NSString *)localFrequency;
-(void)setProgramData:(ProgrammaModel *)programData;

@end
