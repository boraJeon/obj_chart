//
//  LineData.h
//  SampleProject
//
//  Created by OpenIT on 2017. 1. 25..
//  Copyright © 2017년 OpenIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LineData : NSObject

@property (nonatomic) double max;
@property (nonatomic) double min;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *fillColor;

@property (nonatomic, strong) UIImage *dotImg;

@property (nonatomic, strong) NSString *minTitle;
@property (nonatomic, strong) NSString *maxTitle;

@end
