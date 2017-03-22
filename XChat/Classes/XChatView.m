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
    UIView *_viewY;
}
// 盛放纵坐标的label
@property (nonatomic, strong) NSMutableArray *rateLabels;
// 盛放横坐标的progressView
@property (nonatomic, strong) NSMutableArray *progressViews;
// 利率
@property (nonatomic, strong) NSArray *rateArr;
// 持有天数
@property (nonatomic, assign) int holdDay;

@end

@implementation XChatView


- (instancetype)initWithFrame:(CGRect)frame columns: (int)columns rows: (int)rows {
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
    _viewY = viewY;
    
    /// 纵坐标的刻度值及线
    for (int i = 0; i < _rows; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(titleLabel.frame) + kMargin * 2 + kLabelHeight * i, kWidthY, kLabelHeight)];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [self.rateLabels addObject:label];
        
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
        
        
        XProgressView *proView = [[XProgressView alloc] init];
        [self addSubview:proView];
        [self.progressViews addObject:proView];
        if (proView.frame.size.height < proView.frame.size.width * 0.5) {
            proView.layer.masksToBounds = YES;
        }
    }
}

#pragma mark - setter and getter
- (void)setHoldDay:(int)holdDay rateArr:(NSArray *)rateArr  {
    self.holdDay = holdDay;
    self.rateArr = rateArr;
}

- (void)setRateArr:(NSArray *)rateArr {
    _rateArr = rateArr;
    
    CGFloat maxRate =  [[rateArr valueForKeyPath:@"@max.floatValue"] floatValue];
    double minRate = maxRate - (int)(maxRate / _rows) * (_rows - 2);
    
    for (int i = 0; i < _rows; i++) {
        UILabel *label = self.rateLabels[i];
        label.text = [NSString stringWithFormat:@"%.2f%%", maxRate - (int)(maxRate / _rows) * i];
        if (maxRate < _rows) {
            label.text = [NSString stringWithFormat:@"%.2f%%", maxRate - (CGFloat)(maxRate / (_rows - 1)) * i];
        }
        if (i == _rows - 1) {
            label.text = @"月份";
        }
    }
    
    CGFloat margin = 0;
    for (int i = 1; i <= _columns; i++) {
        margin = (kScreenWidth - kWidthY - 3 *kMargin - 15 * _columns) / (_columns + 1);
        
        CGFloat progressH = 0;
        double rate = [_rateArr[i - 1] doubleValue];
        
        if (maxRate < _rows) {
            double marginRate = (CGFloat)maxRate / (_rows - 1);
            progressH = (rate / marginRate * kLabelHeight);
        } else {
            if ( rate <= minRate) {
                progressH = (rate / minRate * kLabelHeight);
            } else {
                progressH = kLabelHeight + (CGFloat)((rate - minRate) / (maxRate / _rows)) * kLabelHeight;
            }
        }
        XProgressView *proView = self.progressViews[i - 1];
        proView.frame = CGRectMake(CGRectGetMaxX(_viewY.frame) + margin * i + 15 * (i - 1), _rows * kLabelHeight + 3 * kMargin - progressH, 15, progressH);
        
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

- (NSMutableArray *)rateLabels {
    if (!_rateLabels) {
        _rateLabels = [NSMutableArray array];
    }
    return _rateLabels;
}

- (NSMutableArray *)progressViews {
    if (!_progressViews) {
        _progressViews = [NSMutableArray array];
    }
    return _progressViews;
}

@end
