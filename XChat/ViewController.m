//
//  ViewController.m
//  XChat
//
//  Created by sajiner on 2017/3/10.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "ViewController.h"
#import "XChatView.h"

@interface ViewController ()

@property (nonatomic, strong) XChatView *chatView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view addSubview:self.chatView];
    
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.fillColor = [UIColor redColor].CGColor;
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
//    [path addLineToPoint:CGPointMake(80, 100)];
//    layer.path = path.CGPath;
//    [self.view.layer addSublayer:layer];
}


- (XChatView *)chatView {
    if (!_chatView) {
        NSArray *arr = @[@(6.5), @(1), @(2.8), @(14.5), @(2.3), @(16.5), @(7), @(7.3), @(2.8), @(14.5), @(12.3), @(16.5)];
        _chatView = [[XChatView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300) columns:12 rows:7 maxRate:13.4 holdDay:200 rateArr:arr];
        _chatView.backgroundColor = [UIColor orangeColor];
    }
    return _chatView;
}


@end
