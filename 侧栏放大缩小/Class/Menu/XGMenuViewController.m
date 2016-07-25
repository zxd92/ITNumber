//
//  XGMenuViewController.m
//  侧栏放大缩小
//
//  Created by 小果 on 16/3/5.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGMenuViewController.h"
#import "XGMenuCell.h"

 static NSString *ID = @"menuCell";

@interface XGMenuViewController ()
@property (nonatomic, strong) NSArray *menulist;
@end

@implementation XGMenuViewController

-(NSArray *)menulist{
    
    if (!_menulist){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"navmenu.plist" ofType:nil];
        _menulist = [NSArray arrayWithContentsOfFile:path];
    }
    return _menulist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = (self.view.bounds.size.height - 100) / self.menulist.count;
    
    // 为表格注册可重用的单元格(用XGMenuCell实例化出来的单元格是可重用的单元格)
    [self.tableView registerClass:[XGMenuCell class] forCellReuseIdentifier:ID];
    
}

#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menulist.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    NSDictionary *dict = self.menulist[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:dict[@"imageName"]];
    cell.textLabel.text = dict[@"title"];
    
    return cell;
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.menulist[indexPath.row];
    NSLog(@"%@",dict);
    
    // 通知RootViewController更新视图控制器
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MenuViewControllerSelectedItem" object:dict[@"className"] userInfo:nil];
    
}

@end
