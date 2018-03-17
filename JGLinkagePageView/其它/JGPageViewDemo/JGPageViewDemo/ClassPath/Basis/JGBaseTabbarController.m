//
//  JGBaseTabbarController.m
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/10.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGBaseTabbarController.h"
#import "JGBaseNavigationController.h"

#import "JGHomeViewController.h"
#import "JGNewsViewController.h"
#import "JGPlusViewController.h"
#import "JGMineViewController.h"



@interface JGBaseTabbarController ()

@end

@implementation JGBaseTabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupChildVc:[[JGHomeViewController alloc] init] title:@"首页" image:@"tabBar_friendTrends_icon"  selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[JGNewsViewController alloc] init] title:@"新品" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[JGPlusViewController alloc] init] title:@"Plus会员" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setupChildVc:[[JGMineViewController alloc] init] title:@"我的" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
}

/**
 *  初始化控制器
 *
 *  @param vc            控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //包装一个导航控制器
    JGBaseNavigationController *nav = [[JGBaseNavigationController alloc] initWithRootViewController:vc];
    //隐藏tabbar
    [self addChildViewController:nav];

//    if ([vc isKindOfClass:[JGHomeViewController class]]) {
//         [self addChildViewController:vc];
//    }else {
//        [self addChildViewController:nav];
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
