//
//  JGFiveController.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGFiveController.h"
#import "JGPageView.h"
#import "JGTwoBrandController.h"
#import "JGOneBrandController.h"


@interface JGFiveController () <UINavigationControllerDelegate,JGPageViewDelegate>

@end

@implementation JGFiveController


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
            [childVcArray addObject:vc];
        }else if (i == 1) {
            
            JGTwoBrandController *vc = [[JGTwoBrandController alloc] init];
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
    
    
    JGPageView *pageView = [[JGPageView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) titles:testArray.mutableCopy style:nil childVcs:childVcArray.mutableCopy parentVc:self];
    pageView.delegate = self;
    
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];
    

    
}


#pragma mark - JGPageViewDelegate
- (void)pageViewScollEndView:(JGPageView *)pageView WithIndex:(NSInteger)index
{
    NSLog(@"第%zd类品牌",index+1);
}


@end
