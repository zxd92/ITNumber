//
//  XGContentViewController.m
//  侧栏放大缩小
//
//  Created by 小果 on 16/3/5.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGContentViewController.h"

@interface XGContentViewController ()

@end

@implementation XGContentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.textColor = [UIColor redColor];
    lab.text = @"显示内容";
    lab.frame = CGRectMake(0, 0, 100, 40);
    self.navigationItem.titleView = lab;
    
    
}

@end
