//
//  XGDrawerViewController.h
//  侧栏放大缩小
//
//  Created by 小果 on 16/3/5.
//  Copyright © 2016年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGDrawerViewController : UIViewController

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *mainView;

-(void)resetLocation;

@end
