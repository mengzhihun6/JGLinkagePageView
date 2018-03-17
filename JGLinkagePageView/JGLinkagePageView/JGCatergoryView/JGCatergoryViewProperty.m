//
//  JGCatergoryViewProperty.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGCatergoryViewProperty.h"

@implementation JGCatergoryViewProperty


- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleFont = [UIFont systemFontOfSize:15];
        _titleColorChangeEable = YES;
        _titleColor = [UIColor whiteColor];
        _titleSelectColor = [UIColor redColor];
        _itemSpacing = 10;
        _edgeSpacing = 20;
        _scaleRatio = 1.1;
    }
    return self;
}

- (CGFloat)scaleRatio{
    return _scaleEnable ? _scaleRatio : 1.0f;
}


@end
