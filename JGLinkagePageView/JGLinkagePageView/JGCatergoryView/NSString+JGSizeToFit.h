//
//  NSString+JGSizeToFit.h
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (JGSizeToFit)
/**
 *  根据字符串返回自适应的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大限制尺寸
 *
 *  @return 自适应后的尺寸
 */
- (CGSize)jg_sizeWithfont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  根据字符串返回自适应的尺寸,用于计算属性字符串
 *
 *  @param attrs   属性
 *  @param maxSize 最大限制尺寸
 *
 *  @return 自适应后的尺寸
 */

- (CGSize)jg_sizeWithAttrs:(NSDictionary *)attrs maxSize:(CGSize)maxSize;

@end
