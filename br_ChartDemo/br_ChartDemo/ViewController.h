//
//  ViewController.h
//  br_ChartDemo
//
//  Created by Mac on 2018. 1. 23..
//  Copyright © 2018년 Bora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

