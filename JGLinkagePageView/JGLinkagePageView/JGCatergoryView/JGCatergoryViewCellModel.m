//
//  JGCatergoryViewCellModel.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGCatergoryViewCellModel.h"

@implementation JGCatergoryViewCellModel

- (CGRect)cellFrame{
    return CGRectMake(_cellCenter.x - _cellSize.width / 2.0f, _cellCenter.y - _cellSize.height / 2.0f, _cellSize.width, _cellSize.height);
}

- (CGRect)backEllipseFrame{
    return CGRectMake(_cellCenter.x - _cellSize.width / 2.0f - 5, _cellCenter.y - _cellSize.height / 2.0f - 2, _cellSize.width + 10, _cellSize.height + 4);
}

- (CGFloat)valueRatio{
    return (1 - fabs(_ratio - _index)) <= 0 ? 0 : (1 - fabs(_ratio - _index));
}

@end
