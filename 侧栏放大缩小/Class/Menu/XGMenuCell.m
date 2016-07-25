//
//  XGMenuCell.m
//  侧栏放大缩小
//
//  Created by 小果 on 16/3/5.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGMenuCell.h"

@implementation XGMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 以下的两个属性之所以写在这里，是因为这两个属性只需设置一次，没必要设置多次
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        // 取消cell的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    }else{
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    
}

@end
