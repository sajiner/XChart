//
//  XChatView.m
//  XChat
//
//  Created by sajiner on 2017/3/10.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XChatView.h"
#import "XProgressView.h"

#define kHeight self.bounds.size.height

@interface XChatView () {
    int _columns;
    int _rows;
}

@end

@implementation XChatView

- (instancetype)initWithFrame:(CGRect)frame columns:(int)columns rows:(int)rows {
    self = [super initWithFrame:frame];
    if (self) {
        _columns = columns;
        _rows = rows;
        [self initELement];
    }
    return self;
}

- (void)initELement {
    /// 柱状图标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 16, kScreenWidth - 30, 30)];
    titleLabel.text = @"过往年化收益";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLabel];
    
    /// 柱状图解释
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, kHeight - 26, kScreenWidth - 30, 30)];
    detailLabel.text = @"持有时长（月），每月=30天";
    detailLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:detailLabel];
    
    /// y轴
    UIView *viewY = [[UIView alloc] initWithFrame:CGRectMake(45,  CGRectGetMaxY(titleLabel.frame) + 10, 1, kHeight - 110)];
    viewY.backgroundColor = [UIColor grayColor];
    [self addSubview:viewY];
    
    /// 纵坐标的刻度值及线
    for (int i = 0; i < _rows; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame) + 20 + 30 * i, 30, 30)];
        label.text = [NSString stringWithFormat:@"%d%%", 14 - 2 * i];
        if (i == _rows - 1) {
            label.text = @"月份";
        }
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        
        UIView *lineX = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), label.frame.origin.y, kScreenWidth - CGRectGetMaxX(label.frame) - 12, 1)];
        lineX.backgroundColor = [UIColor grayColor];
        [self addSubview:lineX];
    }
    
    /// 横坐标的刻度值
    for (int i = 1; i <= _columns; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(viewY.frame) + 10 * i + 15 * (i - 1),kHeight - 56 , 15, 30)];
        label.text = [NSString stringWithFormat:@"%d", i];
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        
        XProgressView *proView = [[XProgressView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(viewY.frame) + 10 * i + 15 * (i - 1), kHeight - 56 - 98, 15, 100)];
        proView.progress = 0.5;
        [self addSubview:proView];
    }
    
}

@end
