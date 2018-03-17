//
//  JGPageView.h
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/12.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGTitleStyle.h"
#import "JGTitleView.h"
#import "JGContentView.h"

@class JGPageView;
@protocol JGPageViewDelegate <NSObject>

//页面切换完成之后
@optional
- (void)pageViewScollEndView:(JGPageView *)pageView WithIndex:(NSInteger)index;

@end


@interface JGPageView : UIView

/**
 直接在需要PageView的控制器中，一句代码实例化(调用此方法),如需更改TitleView的样式在JGTitleStyle.m中重新设置即可
 
 @param frame PageView的Frame
 @param titles 标题数组
 @param style 设置PageView的多个属性
 @param childVcs 子控制器数组
 @param parentVc 父控制器
 @return pageView
 */
- (JGPageView *)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles style:(JGTitleStyle *)style childVcs:(NSArray <UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc;


@property(nonatomic, weak) id <JGPageViewDelegate> delegate;



@end
