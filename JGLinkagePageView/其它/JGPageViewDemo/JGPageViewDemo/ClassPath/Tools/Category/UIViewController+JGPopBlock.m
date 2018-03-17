//
//  UIViewController+JGPopBlock.m
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/12.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "UIViewController+JGPopBlock.h"
#import <objc/runtime.h>

static char popBlockKey;

@implementation UIViewController (JGPopBlock)

-(void)setPopBlock:(PopBlock)popBlock{
    objc_setAssociatedObject(self, &popBlockKey, popBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(PopBlock)popBlock{
    
    PopBlock popBlock = objc_getAssociatedObject(self, &popBlockKey);
    
    return popBlock;
}

@end
