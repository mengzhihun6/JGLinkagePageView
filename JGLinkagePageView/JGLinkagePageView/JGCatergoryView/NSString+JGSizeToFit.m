//
//  NSString+JGSizeToFit.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "NSString+JGSizeToFit.h"

@implementation NSString (JGSizeToFit)

- (CGSize)jg_sizeWithfont:(UIFont *)font maxSize:(CGSize)maxSize{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)jg_sizeWithAttrs:(NSDictionary *)attrs maxSize:(CGSize)maxSize{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
