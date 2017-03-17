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
    
//    CAShapeLayer *bgLayer = [CAShapeLayer layer];
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 50, 40) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(25, 25)];
//    bgLayer.path = path.CGPath;
//    bgLayer.fillColor = [UIColor lightGrayColor].CGColor;    [self.view.layer addSublayer:bgLayer];
}


- (XChatView *)chatView {
    if (!_chatView) {
        NSArray *arr = @[@(6.5), @(7.3), @(2.8), @(14.5), @(12.3), @(16.5), @(6.5), @(7.3), @(2.8), @(14.5), @(12.3), @(16.5)];
        _chatView = [[XChatView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300) columns:12 rows:7 maxRate:6 holdDay:190 rateArr:arr];
        _chatView.backgroundColor = [UIColor orangeColor];
    }
    return _chatView;
}


@end
