//
//  UIViewController+JGPopBlock.h
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/12.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopBlock)(UIBarButtonItem *backItem);

@interface UIViewController (JGPopBlock)

@property(nonatomic,copy)PopBlock popBlock;

@end
