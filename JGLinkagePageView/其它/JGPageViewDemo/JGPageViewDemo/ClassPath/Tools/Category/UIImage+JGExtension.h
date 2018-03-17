//
//  UIImage+JGExtension.h
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/12.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JGExtension)

//根据当前图像 生成圆角图像 并且返回
- (void)jg_CornerimageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void(^)(UIImage *))completion;


@end
