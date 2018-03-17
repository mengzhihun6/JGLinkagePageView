//
//  JGFourController.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#define WIDTH      [UIScreen mainScreen].bounds.size.width
#define HEIGHT     [UIScreen mainScreen].bounds.size.height

/*
 
 思路
 //1搭建结构
 *自定义控制器JGFourController
 *搭建JGFourController 上下滚动条
 *确定JGFourController 有多少个子控制器,添加自控制器
 
 2.设置上面滚动条标题
 *遍历自控制器
 3.监听滚动条标题点击
 *让标题选中,文字为空色
 *滚动到对应的位置
 *对应的位置添加子控制器View
 
 4.监听滚动完成
 *对应的位置添加子控制器View
 *选择子控制器对应的标题
 
 */

#import "JGFourController.h"
#import "oneViewController.h"
#import "twoViewController.h"
#import "threeViewController.h"
#import "fourViewController.h"
#import "fiveViewController.h"
#import "sixViewController.h"

static int const labelWith = 100;

@interface JGFourController () <UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *titleScrollView;
@property(nonatomic,weak)UIScrollView *contentScrollView;

@property(nonatomic,weak)UILabel *seletLabel;
@property(nonatomic,strong)NSMutableArray *titleArray;


@end

@implementation JGFourController

-(NSMutableArray *)titleArray{
    
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
        
    }
    return _titleArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0.设置页面scrollView;
    [self setScrollViewTopandBottom];
    
    //1.添加所有子控制器
    [self setAllChildController];
    
    
    //2.添加所有子控制器对应标题
    [self setupTitleLabel];
    
    
    //3.初始化标题ScrollView
    [self setupScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


//初始化标题ScrollView
-(void)setupScrollView{
    NSInteger count = self.childViewControllers.count;
    //设置标题滚动条
    self.titleScrollView.contentSize = CGSizeMake(count * labelWith, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    //设置内容滚动条
    self.contentScrollView.contentSize = CGSizeMake(WIDTH*count, 0);
    //开启分页
    self.contentScrollView.pagingEnabled = YES;
    //没有弹簧效果
    self.contentScrollView.bounces = NO;
    //隐藏水平滚动条
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    //设置协议
    self.contentScrollView.delegate = self;
    
}
//设置页面scrollView
-(void)setScrollViewTopandBottom{
    self.navigationController.navigationBar.translucent = NO;
    UIScrollView *Scroll = [[UIScrollView alloc]init];
    Scroll.frame = CGRectMake(0, 0, WIDTH, 44);
    Scroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Scroll];
    self.titleScrollView = Scroll;
    
    UIScrollView *contentScroll = [[UIScrollView alloc]init];
    contentScroll.frame = CGRectMake(0, CGRectGetMaxY(Scroll.frame), WIDTH, self.view.frame.size.height - 64 -44);
    contentScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentScroll];
    self.contentScrollView = contentScroll;
    
}

//添加所有子控制器对应标题
-(void)setupTitleLabel{
    NSInteger count = self.childViewControllers.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = 44;
    for (int i = 0; i < count; i++) {
        //取出控制器
        UIViewController *vc = self.childViewControllers[i];
        
        //创建label
        UILabel *label = [[UILabel alloc]init];
        
        //添加label 到titleArray 数组
        [self.titleArray addObject:label];
        
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        x = i*labelWith;
        label.tag = i;
        
        //设置尺寸
        label.frame = CGRectMake(x, y, labelWith, height);
        
        //设置Label文字
        label.text = vc.title;
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        
        //设置高亮文字颜色
        label.highlightedTextColor = [UIColor redColor];
        
        
        //默认选中第0个label
        if (i == 0) {
            [self titleClick:tap];
        }
        
        
        
        //添加label
        [self.titleScrollView addSubview:label];
        
    }
    
}

#pragma mark -- UISCrollview代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    //1.添加子控制器View
    [self showVC:index];
    
    
    //2.把对应标题选中
    UILabel *label = self.titleArray[index];
    [self selectLabel:label];
    
    //3让选中标题居中
    [self setUpTitleCenter:label];
    
    
}

//滚动就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat currpage = scrollView.contentOffset.x/WIDTH;
    
    //左边角标
    NSInteger leftIndex = currpage;
    
    //右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    
    //获取左边label
    UILabel *leftLabel = self.titleArray[leftIndex];
    
    //获取右边label
    UILabel *rightLabel;
    if (rightIndex <= self.titleArray.count - 1) {
        rightLabel = self.titleArray[rightIndex];
    }
    
    //计算右边缩放比例 右边自己相对于左边字体变大比例
    CGFloat rightscal = currpage - leftIndex;
    
    //计算左边缩放比例
    CGFloat leftscal = 1 - rightscal;
    
    //缩放比例 1~1.3
    //左边缩放比例
    leftLabel.transform = CGAffineTransformMakeScale(leftscal*0.3+1,leftscal*0.3+1);
    
    //右边缩放比例
    rightLabel.transform = CGAffineTransformMakeScale(rightscal*0.3+1,rightscal*0.3+1);
    
    //设置文字颜色渐变
    /**RGB 渐变*/
    leftLabel.textColor = [UIColor colorWithRed:leftscal green:0 blue:0 alpha:1];
    rightLabel.textColor = [UIColor colorWithRed:rightscal green:0 blue:0 alpha:1];
    
    
    
}
//显示页面
-(void)showVC:(NSInteger)index{
    
    CGFloat offsetX = index * WIDTH;
    
    UIViewController *vc = self.childViewControllers[index];
    
    //判断当前控制器的View 有没有加载过 如果已经加载过 就不需要加载
    if (vc.isViewLoaded) return;
    vc.view.frame = CGRectMake(offsetX, 0, WIDTH, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:vc.view];
}

//label点击事件
-(void)titleClick:(UITapGestureRecognizer*)tap{
    //0取出label
    UILabel *label = (UILabel*)tap.view;
    
    //1.标题颜色高亮
    [self selectLabel:label];
    //2.滚动相应位置
    NSInteger index = label.tag;
    //2.1计算滚动位置
    CGFloat offsetX = label.tag * WIDTH;
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    //3.对应位置添加控制器View
    [self showVC:index];
    
    //4.让选中标题居中
    [self setUpTitleCenter:label];
    
}

-(void)selectLabel:(UILabel *)label{
    
    _seletLabel.highlighted = NO;
    //取消形变
    _seletLabel.transform = CGAffineTransformIdentity;
    
    _seletLabel.textColor = [UIColor blackColor];
    label.highlighted = YES;
    
    //形变
    label.transform = CGAffineTransformMakeScale(1.3,1.3);
    
    _seletLabel = label;
    
}


//设置标题居中
-(void)setUpTitleCenter:(UILabel*)centerLabel{
    //计算偏移量
    CGFloat offsetX = centerLabel.center.x - WIDTH*0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    //最大滚动范围
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - WIDTH;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
        
    }
    
    //滚动标题滚动条
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

//添加所有子控制器
-(void)setAllChildController{
    
    //推荐
    oneViewController *oneVC = [[oneViewController alloc]init];
    oneVC.title = @"推荐";
    [self addChildViewController:oneVC];
    
    
    //热点
    twoViewController *twoVC = [[twoViewController alloc]init];
    twoVC.title = @"热点";
    [self addChildViewController:twoVC];
    
    
    //沈阳
    threeViewController *threeVC = [[threeViewController alloc]init];
    threeVC.title = @"沈阳";
    [self addChildViewController:threeVC];
    
    
    //视频
    fourViewController *fourVC = [[fourViewController alloc]init];
    fourVC.title = @"视频";
    [self addChildViewController:fourVC];
    
    
    //社会
    fiveViewController *fiveVC = [[fiveViewController alloc]init];
    fiveVC.title = @"社会";
    [self addChildViewController:fiveVC];
    
    
    //图片
    sixViewController *sixVC = [[sixViewController alloc]init];
    sixVC.title = @"图片";
    [self addChildViewController:sixVC];
    
    
    
}

@end
