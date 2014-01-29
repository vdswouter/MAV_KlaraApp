//
//  PlaylistSongModel.m
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "PlaylistItemModel.h"

@implementation PlaylistItemModel

+(PlaylistItemModel *) createFromJSON:(NSDictionary *)json {
    PlaylistItemModel *playlistItemModel = [[PlaylistItemModel alloc] init];
    
    playlistItemModel.song = [json objectForKey:@"song"];
    playlistItemModel.artist = [json objectForKey:@"artist"];
    playlistItemModel.file = [NSURL URLWithString:[@"http://student.howest.be/pieter.beulque/20132014/mav/audio/" stringByAppendingString:[[json objectForKey:@"full"] objectForKey:@"mp3"]]];

    return playlistItemModel;
}

@end
