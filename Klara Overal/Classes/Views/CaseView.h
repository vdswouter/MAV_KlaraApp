//
//  CaseView.h
//  Klara Overal
//
//  Created by Pieter Beulque on 27/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CloseButton.h"

@interface CaseView : UIView

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblSubtitle;
@property (nonatomic, strong) CloseButton *btnClose;

@end
