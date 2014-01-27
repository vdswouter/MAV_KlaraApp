//
//  PlaylistSongModel.h
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaylistItemModel : NSObject

@property (nonatomic, strong) NSString *song;
@property (nonatomic, strong) NSString *artist;
@property uint duration;

+(PlaylistItemModel *) createFromJSON:(NSDictionary *)json;

@end
