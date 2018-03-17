//
//  UIActivityIndicatorView+JGAdd.h
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>

/**设置主题色*/
#define indicatorColor [UIColor redColor]

@interface UIActivityIndicatorView (JGAdd)

+ (void)jg_showAnimationInView:(UIView *)view;
+ (void)jg_stopAnimationInView:(UIView *)view;
+ (BOOL)jg_isAnimatingInView:(UIView *)view;

@end
