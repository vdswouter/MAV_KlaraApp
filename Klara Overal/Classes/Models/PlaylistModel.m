//
//  PlaylistModel.m
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "PlaylistModel.h"

@implementation PlaylistModel

-(id) init {
    self = [super init];
    if (self) {
        self.title = @"";
        self.subtitle = @"";
        self.description = @"";
    }
    
    return self;
}

@end
