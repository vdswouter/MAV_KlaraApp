//
//  CaseModel.h
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaylistItemModel.h"

@interface CaseModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSArray *playlist;

+(CaseModel *) createFromJSON:(NSDictionary *)json;

@end
