//
//  BMHomeTableViewController.m
//  BMWaveViewDemo
//
//  Created by DingXiao on 15/8/4.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import "BMHomeTableViewController.h"

@interface BMHomeTableViewController ()

@end

@implementation BMHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    self.title = @"Home";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)weibo:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/GreatDingXiao"]];
}

@end
