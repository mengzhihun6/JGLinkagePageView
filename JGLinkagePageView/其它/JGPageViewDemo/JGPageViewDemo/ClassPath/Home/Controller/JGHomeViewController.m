//
//  JGHomeViewController.m
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/10.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGHomeViewController.h"

#import "JGPageView.h"
#import "JGTwoBrandController.h"
#import "JGOneBrandController.h"

@interface JGHomeViewController ()<UINavigationControllerDelegate,JGPageViewDelegate>

@end

@implementation JGHomeViewController


#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    //BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSMutableArray *testArray = [NSMutableArray array];
    
    for (int i = 0; i < 15; i++) {
        [testArray addObject:[NSString stringWithFormat:@"品牌%d",i+1]];
    }
    
    NSMutableArray *childVcArray = [NSMutableArray array];
    for (int i = 0; i < testArray.count; i++) {
        
        if (i == 0) {
            JGOneBrandController *vc = [[JGOneBrandController alloc] init];
            //            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
            //            label.textAlignment = NSTextAlignmentCenter;
            //            label.center = self.view.center;
            //            label.text = testArray[i];
            //            [vc.view addSubview:label];
            [childVcArray addObject:vc];
        }else if (i == 1) {
            
            JGTwoBrandController *vc = [[JGTwoBrandController alloc] init];
            //            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
            //            label.textAlignment = NSTextAlignmentCenter;
            //            label.center = self.view.center;
            //            label.text = testArray[i];
            //            [vc.view addSubview:label];
            [childVcArray addObject:vc];
            
        }else {
            
            UIViewController *vc = [[UIViewController alloc] init];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
            label.textAlignment = NSTextAlignmentCenter;
            label.center = self.view.center;
            label.text = testArray[i];
            [vc.view addSubview:label];
            [childVcArray addObject:vc];
            
        }
    }
    
    
    JGPageView *pageView = [[JGPageView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 64) titles:testArray.mutableCopy style:nil childVcs:childVcArray.mutableCopy parentVc:self];
    pageView.delegate = self;
    
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];

    
    //TEST
    [self showHUDToWindowMessage:@"努力加载中..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeHUD];
    });
    
}


#pragma mark - JGPageViewDelegate
- (void)pageViewScollEndView:(JGPageView *)pageView WithIndex:(NSInteger)index
{
    NSLog(@"第%zd类品牌",index+1);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
