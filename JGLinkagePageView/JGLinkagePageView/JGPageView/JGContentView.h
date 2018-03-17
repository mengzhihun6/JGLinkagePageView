//
//  JGContentView.h
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/12.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGTitleStyle.h"

@class JGContentView;
@protocol JGContentViewDelegate <NSObject>

- (void)contentViewWith:(JGContentView *)contentView progress:(CGFloat)progress sourceIndex:(CGFloat)sourceIndex targetIndex:(CGFloat)targetIndex;

- (void)contentViewEndScrollWithContentView:(JGContentView *)contentView;

- (void)scrollViewDidEndDeceleratingWithIndex:(NSInteger)index;

@end

@interface JGContentView : UIView

/**
 创建ContentView
 
 @param frame ContentView的Frame
 @param childVcs 所有子控制器数组
 @param parentViewController 父控制器
 @param style 标题样式
 @return ContentView
 */
- (JGContentView *)initWithFrame:(CGRect)frame childVcs:(NSArray <UIViewController *>*)childVcs parentViewController:(UIViewController *)parentViewController style:(JGTitleStyle *)style;

/**
 点击标题之后通过代理 滚动视图
 
 @param currentIndex 滚动到第几个
 */
- (void)setCurrentIndex:(NSInteger)currentIndex;


@property(nonatomic, weak) id<JGContentViewDelegate> delegate;



@end
