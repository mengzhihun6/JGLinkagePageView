//
//  UIColor+JGAddExtension.h
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JGAddExtension)

/**
 *  颜色转RGB
 */
+ (NSArray *)jg_changeColorToRGB:(UIColor *)color;

/**
 *  16进制颜色字符串转UIColor
 *
 *  @param stringToConvert 16进制颜色字符串（如：#FFE326）
 *
 *  @return 对应的IColor
 */
+ (UIColor *)jg_colorWithHexString:(NSString *)stringToConvert;
/**
 *  插值两种颜色返回中间的颜色
 *
 *  @param from  起始颜色
 *  @param to    终止颜色
 *  @param ratio 插值比例
 *
 *  @return 插值色
 */
+ (UIColor *)jg_colorWithInterpolationFromValue:(UIColor *)from toValue:(UIColor *)to ratio:(CGFloat)ratio;

@end
