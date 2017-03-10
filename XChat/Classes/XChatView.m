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
#define kMargin 10
#define kWidthY 50
#define kLabelHeight 30


@interface XChatView () {
    int _columns;
    int _rows;
    CGFloat _maxRate;
    int _holdDay;
    NSArray *_rateArr;
}

@end

@implementation XChatView

- (instancetype)initWithFrame:(CGRect)frame columns:(int)columns rows:(int)rows maxRate:(CGFloat)maxRate holdDay:(int)holdDay rateArr:(NSArray *)rateArr {
    self = [super initWithFrame:frame];
    if (self) {
        _columns = columns;
        _rows = rows;
        _maxRate = maxRate;
        _holdDay = holdDay;
        _rateArr = rateArr;
        [self initELement];
    }
    return self;
}

- (void)initELement {
    /// 柱状图标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin, kScreenWidth - 2 * kMargin, kLabelHeight)];
    titleLabel.text = @"过往年化收益";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLabel];
    
    /// 柱状图注释
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 3 * kMargin + (_rows + 1) * kLabelHeight, kScreenWidth - kMargin * 2, kLabelHeight)];
    detailLabel.text = @"持有时长（月），每月=30天";
    detailLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:detailLabel];
    
    /// y轴
    UIView *viewY = [[UIView alloc] initWithFrame:CGRectMake(kMargin + kWidthY,  CGRectGetMaxY(titleLabel.frame) + kMargin, 1, kHeight - kLabelHeight * 3 - 2 * kMargin)];
    viewY.backgroundColor = [UIColor grayColor];
    [self addSubview:viewY];
    
    /// 纵坐标的刻度值及线
    for (int i = 0; i < _rows; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(titleLabel.frame) + kMargin * 2 + kLabelHeight * i, kWidthY, kLabelHeight)];
        label.text = [NSString stringWithFormat:@"%.2f%%", _maxRate - (int)(_maxRate / _rows) * i];
        if (i == _rows - 1) {
            label.text = @"月份";
        }
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UIView *lineX = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), label.frame.origin.y, kScreenWidth - CGRectGetMaxX(label.frame) - kMargin, 1)];
        lineX.backgroundColor = [UIColor grayColor];
        [self addSubview:lineX];
    }
    
    /// 横坐标的刻度值
    CGFloat margin = 0;
    for (int i = 1; i <= _columns; i++) {
        margin = (kScreenWidth - kWidthY - 3 *kMargin - 15 * _columns) / (_columns + 1);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(viewY.frame) + margin * i + 15 * (i - 1),  CGRectGetMinY(detailLabel.frame) - kLabelHeight, 15, kLabelHeight)];
        label.text = [NSString stringWithFormat:@"%d", i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        CGFloat progressH = 0;
        double rate = [_rateArr[i - 1] doubleValue];
        double minRate = _maxRate - (int)(_maxRate / _rows) * (_rows - 2);
        if ( rate <= minRate) {
            progressH = (rate / minRate * kLabelHeight);
        } else {
            progressH = kLabelHeight + (CGFloat)((rate - minRate) / (_maxRate / _rows)) * kLabelHeight;
        }
        
        XProgressView *proView = [[XProgressView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(viewY.frame) + margin * i + 15 * (i - 1), _rows * kLabelHeight + 3 * kMargin - progressH, 15, progressH)];
        [self addSubview:proView];
        if (i <= (int)(_holdDay / 30)) {
            proView.progress = 1;
            continue;
        }
        if ((int)(_holdDay % 30) > 0 && i == (int)(_holdDay / 30) + 1) {
            
            proView.progress = ((CGFloat)(_holdDay - 30 * (_holdDay / 30)) / 30);
            continue;
        }
        proView.progress = 0;
    }
    
}

@end
