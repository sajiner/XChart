//
//  XChatView.h
//  XChat
//
//  Created by sajiner on 2017/3/10.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width


@interface XChatView : UIView


/**
 初始化

 @param frame frame
 @param columns 有多少列
 @param rows 有多少行
 @param maxRate 最大利率
 @param holdDay 持有天数
 @return XChatView 的对象
 */
- (instancetype)initWithFrame:(CGRect)frame columns: (int)columns rows: (int)rows maxRate: (CGFloat)maxRate holdDay: (int)holdDay rateArr: (NSArray *)rateArr;

@end
