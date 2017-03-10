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
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGSize size;
    if (w * _progress > h) {
        size = CGSizeMake(h * 0.5, h * 0.5);
    } else {
        size = CGSizeMake(w * _progress * 0.5, w * _progress * 0.5);
    }
    
    UIBezierPath *path1 = nil;
    if (_progress > 0.5) {
        path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, w * _progress, h) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:size];
    } else {
        path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, w * _progress, h) byRoundingCorners:UIRectCornerTopLeft cornerRadii:size];
    }
    _progressLayer.path = path1.CGPath;
}

@end
