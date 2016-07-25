//
//  XGDrawerViewController.m
//  侧栏放大缩小
//
//  Created by 小果 on 16/3/5.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGDrawerViewController.h"

#define kMaxOffsetY 100.0
#define kMaxRightX 280.0
#define kMaxLeftX  -220.0
@interface XGDrawerViewController ()

/** 是否拖动  */
@property (nonatomic, assign, getter=isDraging) BOOL Draging;
/** 是否动画  */
@property (nonatomic, assign, getter=isAnimation) BOOL isAnimation;

@end

@implementation XGDrawerViewController

/** 用代码简历界面的视图层次结构(将所有可见的全部创建) */

-(void)loadView {
    
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"sidebar_bg.jpg"];
    [self.view addSubview:imageView];
    
    // 1、左边视图
    self.leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.leftView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.leftView];
    
    // 2、右边视图
    self.rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.rightView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.rightView];
    
    // 3、主视图
    self.mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.mainView.backgroundColor = [UIColor brownColor];
    [self.view addSubview: self.mainView];
    
}

// 修改状态栏样式
-(UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    // 添加一个观察者
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
   
    // 如果用动画来设置frame，KVO不会调整视图
    if (self.isAnimation) return;
    
    // 如果使用self.mianView.frame.origin.x > 0  向右
    if(self.mainView.frame.origin.x > 0){
        // 显示左侧视图
        self.leftView.hidden = NO;
        self.rightView.hidden = YES;
    }else {
        // 显示右侧视图
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
    }

}

#pragma mark - 触摸事件

/** 使用偏移的X值，来计算主视图目标的位置frame */
-(CGRect)rectWithOffsetX:(CGFloat)x{
    // 窗口大小
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    
    // 1、计算Y
    CGFloat y = x * kMaxOffsetY / windowSize.width;
    // 2、计算缩放的比例大小
    CGFloat scale = (windowSize.height - 2 * y) / windowSize.height;
    // 如果 X < 0,同样要缩小
    if (self.mainView.frame.origin.x < 0){
        scale = 2 - scale;
    }
    
//    NSLog(@"%f",scale);
    // 3、根据缩放的比例来计算mainView的新的frame
    CGRect frame = self.mainView.frame;
    // 3.1 用缩放的比例来计算宽高
    frame.size.width = frame.size.width * scale;
    frame.size.height = frame.size.height * scale;
    frame.origin.x += x;
    frame.origin.y = (windowSize.height - frame.size.height) * 0.5;
    
    return frame;
}

// 手指拖动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 记录是拖动的
    self.Draging = YES;
    
    // 取出触摸
    UITouch *touch = touches.anyObject;
    // 1、取出当前的触摸点
    CGPoint currentLocation = [touch locationInView:self.view];
    // 2、取出之前的触摸点
    CGPoint previouLocation = [touch previousLocationInView:self.view];
    // 3、计算水平的偏移量
    CGFloat offsetX = currentLocation.x - previouLocation.x;
    // 4、设置视图的位置
//    self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, offsetX, 0);
    self.mainView.frame = [self rectWithOffsetX:offsetX];
}

// 抬起手指时，让主视图定位
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    // 如果不是拖动的就直接恢复到原来的位置
    if (!self.isDraging && self.mainView.frame.origin.x != 0){
     
        [self resetLocation];
        return;
    }
    
    // 此处需要根据mainView.X的值来确定目标的位置
    // ①当 X > W * 0.5,让主视图移动到右边(要用到目标的X值)
    // ②当 X + width < W * 0.5,让主视图移动到左边(要用到目标的X值)
    // ③其他情况和主窗口一样大小(要用到目标的X值)
    CGRect frame = self.mainView.frame;
    
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    
    CGFloat targetX = 0;
    
    if (frame.origin.x > windowSize.width * 0.5){
        
        targetX = kMaxRightX;
        
    }else if(CGRectGetMaxX(frame) < windowSize.width * 0.5){
        
        targetX = kMaxLeftX;
    }
    // 计算出水平的偏移量
    CGFloat offsetX = targetX - frame.origin.x;
    
    self.isAnimation = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (targetX != 0){
            
            self.mainView.frame = [self rectWithOffsetX:offsetX];
            
        }else {
            
            self.mainView.frame = self.view.bounds;
        }
        
    } completion:^(BOOL finished) {
        
        self.Draging = NO;
        self.isAnimation = NO;
    }];
}

// 恢复原来的位置
-(void)resetLocation {
    
    self.isAnimation = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.mainView.frame = self.view.bounds;
        
    }completion:^(BOOL finished) {
        
        self.isAnimation = NO;
        
    }];
}

@end
