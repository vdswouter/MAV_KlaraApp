//
//  PlaylistTableViewCell.m
//  Klara Overal
//
//  Created by Pieter Beulque on 28/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import "PlaylistTableViewCell.h"

@implementation PlaylistTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.lblSong = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 260, 20)];
        self.lblSong.textColor = [UIColor blackColor];
        self.lblSong.font = [UIFont fontWithName:@"Calibre-Semibold" size:14];
        self.lblSong.text = @"Song placeholder";
        [self addSubview:self.lblSong];

        self.lblArtist = [[UILabel alloc] initWithFrame:CGRectMake(10, 33, 260, 20)];
        self.lblArtist.textColor = [UIColor blackColor];
        self.lblArtist.font = [UIFont fontWithName:@"Calibre-Light" size:14];
        self.lblArtist.text = @"Artist placeholder";
        [self addSubview:self.lblArtist];
        
        self.borderBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 59, CGRectGetWidth(self.frame), 1)];
        self.borderBottom.backgroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:0.15f];
        [self addSubview:self.borderBottom];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.backgroundColor = [UIColor clearColor];

    if (selected) {
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        self.borderBottom.frame = CGRectMake(0, 56, 320, 4);
        self.borderBottom.backgroundColor = [UIColor blackColor];
    } else {
        self.borderBottom.frame = CGRectMake(0, 59, 320, 1);
        self.borderBottom.backgroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:0.15f];
    }
}

@end
