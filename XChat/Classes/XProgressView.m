//
//  XProgressView.m
//  XChat
//
//  Created by sajiner on 2017/3/10.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XProgressView.h"

#define w self.bounds.size.width
#define h self.bounds.size.height

@interface XProgressView () {
    CAShapeLayer *_progressLayer;
    CAShapeLayer *_trackLayer;
    CAShapeLayer *_bgLayer;
    CAShapeLayer *_bLayer;
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
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, w * 0.5, w, h - w * 0.5)];
//    bgLayer.path = path.CGPath;
    bgLayer.fillColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:bgLayer];
    _bgLayer = bgLayer;
    // 顶部圆环
    CAShapeLayer *bLayer = [CAShapeLayer layer];
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(w * 0.5, w * 0.5) radius:w * 0.5 startAngle:-M_PI endAngle: 0 clockwise:YES];
//    bLayer.path = path1.CGPath;
    bLayer.fillColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:bLayer];
    _bLayer = bLayer;
    
    /// 显示进度的layer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.fillColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:_progressLayer];
    
    // 顶部圆环
    _trackLayer = [CAShapeLayer layer];
    _trackLayer.fillColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:_trackLayer];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, w * 0.5, w, h - w * 0.5)];
    _bgLayer.path = path.CGPath;
    
    UIBezierPath *path0 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(w * 0.5, w * 0.5) radius:w * 0.5 startAngle:-M_PI endAngle: 0 clockwise:YES];
    _bLayer.path = path0.CGPath;
    
    CGSize size;
    if (w * _progress > h) {
        size = CGSizeMake(h * 0.5, h * 0.5);
    } else {
        size = CGSizeMake(w * _progress * 0.5, w * _progress * 0.5);
    }
    
    UIBezierPath *path1 = nil;
    path1 = [UIBezierPath bezierPathWithRect:CGRectMake(0, w * 0.5, w * _progress, h - w * 0.5)];
    
    UIBezierPath *path2;
    if (_progress > 0.5) {
        path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(w * 0.5, w * 0.5) radius:w * 0.5 startAngle:-M_PI endAngle:  -acos(2 * _progress - 1) clockwise:YES];
    } else {
        
        path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(w * 0.5, w * 0.5) radius:w * 0.5 startAngle:-M_PI endAngle:-M_PI + acos(1 - _progress * 2) clockwise:YES];
        
    }
//    NSLog(@"%f", -M_PI + acos(1 - _progress));
    [path2 addLineToPoint:CGPointMake(w * _progress, w * 0.5)];
    _trackLayer.path = path2.CGPath;
    
    _progressLayer.path = path1.CGPath;
}

@end
