//
//  PlaylistTableViewCell.h
//  Klara Overal
//
//  Created by Pieter Beulque on 28/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaylistTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *lblSong;
@property (strong, nonatomic) UILabel *lblArtist;
@property (strong, nonatomic) UILabel *lblDuration;
@property (strong, nonatomic) UIView *borderBottom;


@end
