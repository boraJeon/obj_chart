//
//  ViewController.m
//  br_ChartDemo
//
//  Created by Mac on 2018. 1. 23..
//  Copyright © 2018년 Bora. All rights reserved.
//

#import "ViewController.h"
#import "LineChartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self.mTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0 :
            cell.textLabel.text = @"LineChart";
            break;
        case 1 :
            cell.textLabel.text = @"CurveChart";
            break;
        default :
            cell.textLabel.text = @"default";
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LineChartViewController *lineChartVC = [storyboard instantiateViewControllerWithIdentifier: @"lineChartVC"];
            [self.navigationController pushViewController:lineChartVC animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
