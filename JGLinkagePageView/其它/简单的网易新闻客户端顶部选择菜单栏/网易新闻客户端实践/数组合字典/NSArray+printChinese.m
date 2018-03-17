//
//  NSArray+printChinese.m
//  数组输出中文
//
//  Created by tim on 16/3/17.
//  Copyright © 2016年 tim. All rights reserved.
//

#import "NSArray+printChinese.h"

@implementation NSArray (printChinese)
//用%@打印数组没有调用description方法
- (NSString *)description{
   return @"调用description";
}
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *mString = [NSMutableString string];
    [mString appendString:@"("];
    for (id object in self) {
        [mString appendFormat:@"\n\t%@,", object];
    }
    [mString appendString:@"\n)"];
    return mString;
}
@end
