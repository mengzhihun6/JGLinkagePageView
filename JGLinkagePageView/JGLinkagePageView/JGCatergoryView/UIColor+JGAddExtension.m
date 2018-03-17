//
//  UIColor+JGAddExtension.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "UIColor+JGAddExtension.h"

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation UIColor (JGAddExtension)

+ (UIColor *)jg_colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (NSArray *)jg_changeColorToRGB:(UIColor *)color{
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();//kCGImageAlphaNoneSkipLast
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    return @[@(resultingPixel[0] / 255.0f), @(resultingPixel[1] / 255.0f), @(resultingPixel[2] / 255.0f)];
}

+ (UIColor *)jg_colorWithInterpolationFromValue:(UIColor *)from toValue:(UIColor *)to ratio:(CGFloat)ratio{
    NSArray *fromColorArray = [self jg_changeColorToRGB:from];
    NSArray *toColorArray = [self jg_changeColorToRGB:to];
    CGFloat red = [self xwp_interpolationFromValue:[fromColorArray[0] floatValue] toValue:[toColorArray[0] floatValue] ratio:ratio];
    CGFloat green = [self xwp_interpolationFromValue:[fromColorArray[1] floatValue] toValue:[toColorArray[1] floatValue] ratio:ratio];
    CGFloat blue = [self xwp_interpolationFromValue:[fromColorArray[2] floatValue] toValue:[toColorArray[2] floatValue] ratio:ratio];
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
}

+ (CGFloat)xwp_interpolationFromValue:(CGFloat)from toValue:(CGFloat)to ratio:(CGFloat)ratio{
    return from + (to - from) * ratio;
}

@end
