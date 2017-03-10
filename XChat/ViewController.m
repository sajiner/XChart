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
}


- (XChatView *)chatView {
    if (!_chatView) {
        _chatView = [[XChatView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300) columns:12 rows:7];
        _chatView.backgroundColor = [UIColor orangeColor];
    }
    return _chatView;
}


@end
