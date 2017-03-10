//
//  XProgressView.m
//  XChat
//
//  Created by sajiner on 2017/3/10.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XProgressView.h"

@interface XProgressView () {
    CAShapeLayer *_progressLayer;
}


@end

@implementation XProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElement];
    }
    return self;
}

- (void)initElement {
    /// 灰色背景
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5)];
    bgLayer.path = path.CGPath;
    bgLayer.fillColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:bgLayer];
    
    /// 显示进度的layer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.fillColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:_progressLayer];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width * _progress, self.frame.size.height) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5)];
    _progressLayer.path = path1.CGPath;
}

@end
