//
//  ChannelViewController.h
//  网易新闻客户端实践
//
//  Created by 杨金发 on 2017/2/20.
//  Copyright © 2017年 杨金发. All rights reserved.
//

#import <UIKit/UIKit.h>
//设置返回刷新代理
@protocol BackRefreshDelegate <NSObject>

//返回刷新方法
-(void)backToRefresh;

//指定频道返回并刷新
-(void)setChannelText:(NSString*)text andIndex:(NSInteger)index;

@end

@interface ChannelViewController : UIViewController

@property(nonatomic,strong)id<BackRefreshDelegate> bacreFreshDelegate;

@end
