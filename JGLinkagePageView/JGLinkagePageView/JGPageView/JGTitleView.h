//
//  JGTitleView.h
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/12.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGTitleStyle.h"

@class JGTitleView;

@protocol JGTitleViewDelegate <NSObject>

- (void)titleViewWithTitleView:(JGTitleView *)titleView selectedIndex:(NSInteger)selectedIndex;

@end

@interface JGTitleView : UIView

- (JGTitleView *)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles style:(JGTitleStyle *)style;

- (void)setTitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

- (void)contentViewDidEndScroll;

@property(nonatomic, weak) id<JGTitleViewDelegate> delegate;


@end
