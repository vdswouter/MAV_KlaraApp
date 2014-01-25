//
//  ProgrammaModel.h
//  Klara Overal
//
//  Created by Wouter Vandersyppe on 25/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgrammaModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *presenter;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *imgURL;

-(id)init;

@end
