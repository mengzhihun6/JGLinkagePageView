//
//  JGTitleStyle.m
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/12.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGTitleStyle.h"

@implementation JGTitleStyle


- (instancetype)init{
    if (self = [super init]) {
        
        self.isTitleViewScrollEnable = YES;
        self.isContentViewScrollEnable = YES;
        self.normalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        self.selectedColor = [UIColor orangeColor];
        self.font = [UIFont systemFontOfSize:14.0];
        self.titleMargin = 0.0;
        self.isShowBottomLine = YES;
        self.bottomLineColor = [UIColor orangeColor];
        self.bottomLineH = 2.0;
        self.isNeedScale = YES;
        self.scaleRange = 1.2;
        self.isShowCover = NO;
        self.coverBgColor = [UIColor yellowColor];
        self.coverMargin = 0.0;
        self.coverH = 25.0;
        self.coverRadius = 5;
    }
    return self;
}

@end
