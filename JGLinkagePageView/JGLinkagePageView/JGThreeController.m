//
//  JGThreeController.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGThreeController.h"
#import "JGCatergoryView.h"
#import "UIView+JGFrameExtension.h"
#import "UICollectionViewFlowLayout+JGFullItem.h"
#import "Masonry/Masonry.h"
#import "JGCollectionViewCell.h"
#import "UIActivityIndicatorView+JGAdd.h"

@interface JGThreeController () <UICollectionViewDataSource, UICollectionViewDelegate, JGCatergoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) JGCatergoryView *catergoryView;
@property (nonatomic, weak) UICollectionView *mainView;

@end

@implementation JGThreeController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //主collectionView
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _mainView = mainView;
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[JGCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
    }];
    //catergoryView
    JGCatergoryView * catergoryView = [JGCatergoryView new];
    _catergoryView = catergoryView;
    catergoryView.titles = self.titles;
    catergoryView.scrollView = mainView;
    catergoryView.delegate = self;
    catergoryView.backgroundColor = [UIColor grayColor];
    //开启缩放
    catergoryView.scaleEnable = YES;
    //设置缩放等级
    catergoryView.scaleRatio = 1.2;
    //开启点击item滑动scrollView的动画
    catergoryView.scrollWithAnimaitonWhenClicked = YES;
    [self.view addSubview:catergoryView];
    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@50);
        make.bottom.equalTo(mainView.mas_top);
    }];
    UIBarButtonItem *loadButton = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(xwp_netReload:)];
    self.navigationItem.rightBarButtonItem = loadButton;
    
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"热门", @"新上榜", @"连载",@"七日热门"];
    }
    return _titles;
}


/**模拟网络刷新*/
- (void)xwp_netReload:(UIBarButtonItem *)sender{
    sender.enabled = NO;
    [UIActivityIndicatorView jg_showAnimationInView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_titles.count == 4) {
            _titles = @[@"热门", @"新上榜", @"连载", @"生活家",@"世间事", @"@IT", @"市集", @"七日热门", @"三十日热门"];
            _catergoryView .itemSpacing = 30;
            
        }else{
            _titles = @[@"热门", @"新上榜", @"连载",@"七日热门"];
        }
        [UIActivityIndicatorView jg_stopAnimationInView:self.view];
        sender.enabled = YES;
        //重新设置数据源
        _catergoryView.titles = _titles;
        //调用如下方法，刷新控件数据
        [_catergoryView jg_realoadData];
        //刷新你自己的collectionview数据
        [_mainView reloadData];
    });
}

/**监听item点击*/
- (void)catergoryView:(JGCatergoryView *)catergoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%zd个item", indexPath.item);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0f green:(arc4random() % 255) / 255.0f blue:(arc4random() % 255) / 255.0f alpha:1.0];
    cell.title = _titles[indexPath.item];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
