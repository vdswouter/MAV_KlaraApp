//
//  QualityPickerButton.h
//  Klara Overal
//
//  Created by Pieter Beulque on 29/01/14.
//  Copyright (c) 2014 Pieter Beulque. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QualityPickerButton : UIButton

@property (nonatomic) BOOL isActive;

- (id)initWithQuality:(NSInteger)quality andTitle:(NSString *)title;

@end
