//
//  CaseModel.m
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "CaseModel.h"

@implementation CaseModel

+(CaseModel *) createFromJSON:(NSDictionary *)json {
    CaseModel *caseModel = [[CaseModel alloc] init];
    
    caseModel.cleanTitle = [json objectForKey:@"class"];
    caseModel.title = [json objectForKey:@"title"];
    caseModel.subtitle = [json objectForKey:@"subtitle"];
    caseModel.description = [[json objectForKey:@"text"] objectAtIndex:0];

    NSArray *jsonPlaylist = [json objectForKey:@"playlist"];
    NSMutableArray *playlist = [NSMutableArray arrayWithCapacity:[jsonPlaylist count]];
    
    for (uint i = 0; i < [jsonPlaylist count]; i++) {
        PlaylistItemModel *playlistItemModel = [PlaylistItemModel createFromJSON:[jsonPlaylist objectAtIndex:i]];
        [playlist addObject:playlistItemModel];
    }
    
    NSDictionary *jsonColor = [json objectForKey:@"color"];
    caseModel.color = [UIColor colorWithRed:[[jsonColor objectForKey:@"r"] floatValue]/255.0f green:[[jsonColor objectForKey:@"g"] floatValue]/255.0f blue:[[jsonColor objectForKey:@"b"] floatValue]/255.0f alpha:1.0f];
        
    caseModel.playlist = [NSArray arrayWithArray:playlist];
    
    return caseModel;
}

@end
