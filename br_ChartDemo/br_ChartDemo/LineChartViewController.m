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
    
    LineData *lineData = [[LineData alloc] init];
    lineData.min = 12.5;
    lineData.max = 16.3;
    lineData.minTitle = @"First_Min";
    lineData.maxTitle = @"First_Max";
    
    lineData.lineColor = UIColorFromRGB(0x2e89e9);
    lineData.fillColor = UIColorFromRGB(0x007dee);
    
    lineData.dotImg = [UIImage imageNamed:@"imgGraphBpCir2"];
    
    LineData *lineData_2 = [[LineData alloc] init];
    lineData_2.min = 10.9;
    lineData_2.max = 13.2;
    lineData_2.minTitle = @"Second_Min";
    lineData_2.maxTitle = @"Second_Max";
    
    lineData_2.lineColor = UIColorFromRGB(0x35b3cb);
    lineData_2.fillColor = UIColorFromRGB(0x00acc8);
    
    lineData_2.dotImg = [UIImage imageNamed:@"imgGraphBpCir2"];
    
    lineChartView.maxValue = max+30;
    lineChartView.lineCount = 2;
    
    lineChartView.startDt = @"2017.12.01";
    lineChartView.endDt = @"2018.12.31";
    
    lineChartView.lineDataArray = @[lineData, lineData_2];
    [lineChartView setNeedsDisplay];
}

@end
