//
//  LineView.h
//  SampleProject
//
//  Created by OpenIT on 2017. 1. 17..
//  Copyright © 2017년 OpenIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView {
    __weak IBOutlet UILabel *leftLabel;
    __weak IBOutlet UILabel *rightLabel;
}

@property (nonatomic) double maxValue;

@property (nonatomic) int lineCount;
@property (nonatomic, strong) NSArray *lineDataArray;

@property (nonatomic, weak) NSString *minStr;
@property (nonatomic, weak) NSString *maxStr;

@end
