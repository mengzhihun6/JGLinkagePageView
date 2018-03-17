//
//  UIActivityIndicatorView+JGAdd.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "UIActivityIndicatorView+JGAdd.h"
#import <objc/runtime.h>

@implementation UIActivityIndicatorView (JGAdd)

+ (void)jg_showAnimationInView:(UIView *)view{
    UIActivityIndicatorView *indicator = objc_getAssociatedObject(view, @"currentIndicator");
    if (!indicator) {
        indicator = [UIActivityIndicatorView new];
        indicator.center = view.center;
        indicator.color = indicatorColor;
        [view addSubview:indicator];
        objc_setAssociatedObject(view, @"currentIndicator", indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (!indicator.isAnimating) {
        [indicator startAnimating];
    }
}

+ (void)jg_stopAnimationInView:(UIView *)view{
    UIActivityIndicatorView *indicator = objc_getAssociatedObject(view, @"currentIndicator");
    if (indicator) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
        objc_removeAssociatedObjects(view);
    }
}

+ (BOOL)jg_isAnimatingInView:(UIView *)view{
    UIActivityIndicatorView *indicator = objc_getAssociatedObject(view, @"currentIndicator");
    return [indicator isAnimating];
    
}

@end
