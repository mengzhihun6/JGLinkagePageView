//
//  UIImage+JGExtension.m
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/12.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "UIImage+JGExtension.h"

@implementation UIImage (JGExtension)

//根据当前图像 生成圆角图像 并且返回
- (void)jg_CornerimageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion {
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        //1.利用绘图 建立上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        //2.设置填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        
        //3.利用贝塞尔 裁切效果
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path closePath];
        
        //4.绘制图像
        [self drawInRect:rect];
        
        //5.取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        //6.关闭图形上下文
        UIGraphicsEndImageContext();
        
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            if (completion != nil) {
                completion(result);
            }
        });
    });
}


@end
