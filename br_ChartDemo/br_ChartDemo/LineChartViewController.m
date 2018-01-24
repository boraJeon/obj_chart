//
//  LineChartViewController.m
//  br_ChartDemo
//
//  Created by Mac on 2018. 1. 23..
//  Copyright © 2018년 Bora. All rights reserved.
//

#import "LineChartViewController.h"
#import "LineData.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LineChartViewController ()

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLineGraph:self.lineChartView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLineGraph:(LineView *)lineChartView {
    double max = 0.f;
//    for (NSDictionary *dic in varArray) {
//        if (max < [[dic valueForKey:dataKey] doubleValue]) {
//            max = [[dic valueForKey:dataKey] doubleValue];
//        }
//
//        [returnArr addObject:[dic valueForKey:dataKey]];
//        [dateArr addObject:[dic valueForKey:@"RECORD_DT"]];
//
//        if ([dataKey isEqualToString:@"GLUCOSE"]) {
//            gluecoseType = [dic valueForKey:@"MEAL"];
//        }
//    }
    
    LineData *lineData = [[LineData alloc] init];
    lineData.min = 12.5;
    lineData.max = 16.3;
    lineData.startDt = @"2017.12.01";
    lineData.endDt = @"2018.12.31";
    
//    if ([dataKey isEqualToString:@"SYS"]) {
        lineData.lineColor = UIColorFromRGB(0x2e89e9);
        lineData.fillColor = UIColorFromRGB(0x007dee);
        
        lineData.dotImg = [UIImage imageNamed:@"imgGraphBpCir2"];
    
//    } else if ([dataKey isEqualToString:@"DIA"]) {
//        lineData.lineColor = UIColorFromRGB(0xf46a2b);
//        lineData.fillColor = UIColorFromRGB(0xf3692b);
//
//        lineData.dotImg = [UIImage imageNamed:@"imgGraphBpCir1"];
//    } else if ([dataKey isEqualToString:@"WEIGHT"]) {
//        lineData.lineColor = UIColorFromRGB(0x35b3cb);
//        lineData.fillColor = UIColorFromRGB(0x00acc8);
//
//        lineData.dotImg = [UIImage imageNamed:@"imgGraphWeightCir1"];
//    } else if ([dataKey isEqualToString:@"BMI"]) {
//        lineData.lineColor = UIColorFromRGB(0xa180de);
//        lineData.fillColor = UIColorFromRGB(0x9d71e0);
//
//        lineData.dotImg = [UIImage imageNamed:@"imgGraphWeightCir2"];
//    } else if ([dataKey isEqualToString:@"GLUCOSE"]) {
//        if ([gluecoseType isEqualToString:@"B"]) {
//            //식전
//            lineData.lineColor = UIColorFromRGB(0x7cb3f0);
//            lineData.fillColor = UIColorFromRGB(0x7bb3f0);
//
//            lineData.dotImg = [UIImage imageNamed:@"imgGraphBsBefore"];
//        } else {
//            //식후
//            lineData.lineColor = UIColorFromRGB(0xf0a115);
//            lineData.fillColor = UIColorFromRGB(0xfd9300);
//
//            lineData.dotImg = [UIImage imageNamed:@"imgGraphBsAfter"];
//        }
//    }
    
    lineChartView.maxValue = max+15;
    lineChartView.lineCount = 1;
    
    lineChartView.lineDataArray = @[lineData];
    [lineChartView setNeedsDisplay];
}

@end
