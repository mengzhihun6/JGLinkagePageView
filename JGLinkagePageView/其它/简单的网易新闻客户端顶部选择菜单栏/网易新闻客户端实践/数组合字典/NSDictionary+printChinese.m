//
//  NSDictionary+printChinese.m
//  定位
//
//  Created by tim on 16/3/20.
//  Copyright © 2016年 tim. All rights reserved.
//

#import "NSDictionary+printChinese.h"

@implementation NSDictionary (printChinese)
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *mString = [NSMutableString string];
    [mString appendString:@"{"];
    for (id key in self) {
        [mString appendFormat:@"\n\t%@ = %@,", key, self[key]];
    }
    [mString appendString:@"\n}"];
    return mString;
}
@end
