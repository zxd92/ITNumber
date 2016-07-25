//
//  XGSettingController.m
//  侧栏放大缩小
//
//  Created by 小果 on 16/3/5.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGSettingController.h"

@interface XGSettingController ()

@end

@implementation XGSettingController

-(void)loadView {
    
    self.view = [[UIView alloc] init];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(152.5, 80, 70, 70);
    [btn setImage:[UIImage imageNamed:@"user_defaultavatar"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"user_defaulthead"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick{
    NSLog(@"%s",__func__);
}

@end
