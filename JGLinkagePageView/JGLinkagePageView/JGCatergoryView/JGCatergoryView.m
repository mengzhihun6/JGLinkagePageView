//
//  JGCatergoryView.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGCatergoryView.h"
#import "JGCatergoryViewLayout.h"
#import "JGCatergoryViewCellModel.h"
#import "JGCatergoryViewCell.h"
#import "NSString+JGSizeToFit.h"
#import "UIView+JGFrameExtension.h"
#import "JGCatergoryViewProperty.h"


@interface JGCatergoryView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, weak) UIView *bottomLine;
@property (nonatomic, weak) CAShapeLayer *backEllipse;
@property (nonatomic, strong) NSIndexPath *lastIndexPath;
@property (nonatomic, strong) JGCatergoryViewProperty *property;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, assign) BOOL firstLoad;
@property (nonatomic, weak) JGCatergoryViewCellModel *fromModel;
@property (nonatomic, weak) JGCatergoryViewCellModel *toModel;
@end

@implementation JGCatergoryView

- (void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - initialize methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jg_initailizeProperty];
        [self jg_initializeUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self jg_initailizeProperty];
    [self jg_initializeUI];
}

- (void)jg_initailizeProperty{
    _scrollWithAnimaitonWhenClicked = YES;
    _clickedAnimationDuration = 0.3;
    _bottomLineColor = [UIColor redColor];
    _bottomLineWidth = 2.0f;
    _bottomLineSpacingFromTitleBottom = 10.0f;
    _backEllipseColor = [UIColor yellowColor];
}


- (void)jg_titlesChanged{
    [self jg_initailzeData];
    _property.titles = _titles;
    _property.data = _data;
}

/**将titles数据转为模型*/
- (void)jg_initailzeData{
    if (!_titles.count) {
        return;
    }
    NSMutableArray *temp = @[].mutableCopy;
    [_titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        JGCatergoryViewCellModel *model = [JGCatergoryViewCellModel new];
        model.title = title;
        model.index = idx;
        [temp addObject:model];
    }];
    _data = temp.copy;
}

- (void)jg_initializeUI{
    JGCatergoryViewLayout *catergoryLayout = [JGCatergoryViewLayout new];
    JGCatergoryViewProperty *property = [JGCatergoryViewProperty new];
    _property = property;
    catergoryLayout.property = property;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:catergoryLayout];
    _mainView = mainView;
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.backgroundColor = self.backgroundColor;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.scrollsToTop = NO;
    [mainView registerClass:[JGCatergoryViewCell class] forCellWithReuseIdentifier:@"JGCatergoryViewCell"];
    [self addSubview:mainView];
    CAShapeLayer * backEllipse = [CAShapeLayer new];
    _backEllipse = backEllipse;
    backEllipse.fillColor = _backEllipseColor.CGColor;
    [mainView.layer addSublayer:_backEllipse];
    UIView *bottomLine = [UIView new];
    _bottomLine = bottomLine;
    bottomLine.backgroundColor = _bottomLineColor;
    [mainView addSubview:bottomLine];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _mainView.frame = self.bounds;
    //初始化各个控件的状态
    NSInteger idx = _lastIndexPath.item;
    [self jg_setNeedUpdateModelWithRatio:idx];
    [self jg_interpolationForBottomLineWithRatio:idx];
    [self jg_interpolationForBackEllipseWithRatio:idx];
    [self jg_interpolationForItemsWithRatio:idx];
}

#pragma mark - setter methods

- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    /**设置scrollView后监听其contentOffset*/
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setItemSpacing:(CGFloat)itemSpacing{
    _itemSpacing = itemSpacing;
    _property.itemSpacing = itemSpacing;
}

- (void)setEdgeSpacing:(CGFloat)edgeSpacing{
    _edgeSpacing = edgeSpacing;
    _property.edgeSpacing = edgeSpacing;
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    _property.titleFont = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    _property.titleColor = titleColor;
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor = titleSelectColor;
    _property.titleSelectColor = titleSelectColor;
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self jg_titlesChanged];
}

- (void)setScaleEnable:(BOOL)scaleEnable{
    _scaleEnable = scaleEnable;
    _property.scaleEnable = scaleEnable;
}

- (void)setScaleRatio:(CGFloat)scaleRatio{
    _scaleRatio = scaleRatio;
    _property.scaleRatio = scaleRatio;
}

- (void)setTitleColorChangeEable:(BOOL)titleColorChangeEable{
    _titleColorChangeEable = titleColorChangeEable;
    _property.titleColorChangeEable = titleColorChangeEable;
}

- (void)setTitleColorChangeGradually:(BOOL)titleColorChangeGradually{
    _titleColorChangeGradually = titleColorChangeGradually;
    _property.titleColorChangeGradually = titleColorChangeGradually;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    _bottomLine.backgroundColor = bottomLineColor;
}

- (void)setBackEllipseColor:(UIColor *)backEllipseColor{
    _backEllipseColor = backEllipseColor;
    _backEllipse.fillColor = backEllipseColor.CGColor;
}

#pragma mark - private methods

/**设置当前需要操作的数据模型*/
- (void)jg_setNeedUpdateModelWithRatio:(CGFloat)ratio{
    if (!_data.count) return;
    _fromModel = _data[(int)ratio];
    if ((int)ratio == _data.count - 1) {
        _toModel = _fromModel;
    }else{
        _toModel = _data[(int)ratio + 1];
    }
}

/**插值bottomLine*/
- (void)jg_interpolationForBottomLineWithRatio:(CGFloat)ratio{
    if (!_bottomLineEable || !_data.count) return;
    CGFloat x = [self jg_interpolationFromValue:_fromModel.cellFrame.origin.x toValue:_toModel.cellFrame.origin.x ratio:ratio - (int)ratio];
    CGFloat y = CGRectGetMaxY(_fromModel.cellFrame) + _bottomLineSpacingFromTitleBottom;
    CGFloat width = [self jg_interpolationFromValue:_fromModel.cellFrame.size.width toValue:_toModel.cellFrame.size.width ratio:ratio - (int)ratio];
    CGFloat height = _bottomLineWidth;
    _bottomLine.frame = CGRectMake(x, y, width, height);
}

/**插值backEllipse*/
- (void)jg_interpolationForBackEllipseWithRatio:(CGFloat)ratio{
    if (!_backEllipseEable || !_data.count) return;
    CGFloat x = [self jg_interpolationFromValue:_fromModel.backEllipseFrame.origin.x toValue:_toModel.backEllipseFrame.origin.x ratio:ratio - (int)ratio];
    CGFloat y = _fromModel.backEllipseFrame.origin.y;
    CGFloat width = [self jg_interpolationFromValue:_fromModel.backEllipseFrame.size.width toValue:_toModel.backEllipseFrame.size.width ratio:ratio - (int)ratio];
    CGFloat height = _fromModel.backEllipseFrame.size.height;
    CGFloat cornerRadius = _fromModel.backEllipseFrame.size.height / 2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, width, height) cornerRadius:cornerRadius];
    _backEllipse.path = path.CGPath;
    [_mainView.layer insertSublayer:_backEllipse atIndex:0];
    
}
/**滚动时，刷新item，不使用reloadData，因为会触发prepareLayout，这里没必要，只有titles变了才需要prepareLayout，这里我采用了遍历所有模型修改模型属性，同时遍历可见item，调用自己的刷新方法达到目的且保证重用，并且不会触发prepareLayout，性能更好，大家可自行测试*/
- (void)jg_interpolationForItemsWithRatio:(CGFloat)ratio{
    for (JGCatergoryViewCellModel *model in _data) {
        model.ratio = ratio;
    }
    for (JGCatergoryViewCell *cell in _mainView.visibleCells) {
        [cell jg_updateCell];
    }
}

- (void)jg_ScrollToIndexPath:(NSIndexPath *)indexPath{
    [_scrollView setContentOffset:CGPointMake(_scrollView.width * indexPath.item, 0) animated:_scrollWithAnimaitonWhenClicked];
    [_mainView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)jg_updateWhenScrollViewDidScroll{
    //拖拽和减速的时候才需要进行update，如果是点击触发的滚动不需要,同时该scrollView需要与初始化传入的scrollView相同
    if (!_scrollView.isDragging && !_scrollView.isDecelerating) {
        return;
    }
    //拖拽比例，根据其进行插值计算
    CGFloat ratio = _scrollView.contentOffset.x / _scrollView.width;
    //到达一个item正位置的时候需要滚动和修正当前的indexPath，这里有个好处，滑动太快，不会调用这个方法，免得滑动太快滚动太频繁
    if ((int)ratio == ratio) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:ratio inSection:0];
        _lastIndexPath = indexPath;
        [_mainView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    //处理边缘情况,因为用户可能开启bounces, 如果越界直接将bottomLine动画到正确位置
    if (ratio <= 0 || ratio >= _data.count - 1) {
        ratio = (int)ratio;
    }
    //先设置需要操作的模型
    [self jg_setNeedUpdateModelWithRatio:ratio];
    //处理bottomLine，对其位置进行插值
    [self jg_interpolationForBottomLineWithRatio:ratio];
    //处理backEllipse，插值
    [self jg_interpolationForBackEllipseWithRatio:ratio];
    //处理前后两个item， 更改模型同时刷新item的状态
    [self jg_interpolationForItemsWithRatio:ratio];
}

- (void)jg_updateBottomLineWhenClickedWithIndexPath:(NSIndexPath *)indexPath{
    if (!_bottomLineEable || !_data.count) return;
    JGCatergoryViewCellModel *model = _data[indexPath.item];
    [UIView animateWithDuration:_clickedAnimationDuration animations:^{
        _bottomLine.frame = CGRectMake(model.cellFrame.origin.x, _bottomLine.y, model.cellSize.width, _bottomLine.height);
    }];
}

- (void)jg_updateBackEllipseWhenClickedWithIndexPath:(NSIndexPath *)indexPath{
    if (!_backEllipseEable || !_data.count) return;
    JGCatergoryViewCellModel *model = _data[indexPath.item];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:model.backEllipseFrame cornerRadius:model.backEllipseFrame.size.width / 2.0f];
    if (_clickedAnimationDuration) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
        anim.duration = 0;
        anim.fromValue = (__bridge id)_backEllipse.path;
        anim.toValue = (__bridge id)path.CGPath;
        [_backEllipse addAnimation:anim forKey:@"pathAnim"];
    }
    _backEllipse.path = path.CGPath;
    [_mainView.layer insertSublayer:_backEllipse atIndex:0];
}

#pragma mark - <UICollectionViewDataSouce>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JGCatergoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JGCatergoryViewCell" forIndexPath:indexPath];
    cell.property = _property;
    cell.data = _data[indexPath.row];
    [_mainView.layer insertSublayer:_backEllipse atIndex:0];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_lastIndexPath.item == indexPath.item) {
        return;
    }
    //设置cell的相应属性
    [self jg_interpolationForItemsWithRatio:indexPath.item];
    //动画bottomLine
    [self jg_updateBottomLineWhenClickedWithIndexPath:indexPath];
    //动画backEllipse
    [self jg_updateBackEllipseWhenClickedWithIndexPath:indexPath];
    //滚动到相应位置
    [self jg_ScrollToIndexPath:indexPath];
    //通知代理
    if (_delegate && [_delegate respondsToSelector:@selector(catergoryView:didSelectItemAtIndexPath:)]) {
        [_delegate catergoryView:self didSelectItemAtIndexPath:indexPath];
    }
    _lastIndexPath = indexPath;
}


#pragma mark - private methods

/**
 *  插值公式
 */
- (CGFloat)jg_interpolationFromValue:(CGFloat)from toValue:(CGFloat)to ratio:(CGFloat)ratio{
    return from + (to - from) * ratio;
}

#pragma mark - public methods

- (void)jg_realoadData{
    [_scrollView setContentOffset:CGPointZero];
    _lastIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [_mainView reloadData];
}

#pragma mark - KVO

/**监听ScrollView的ContentOffset，一旦滚动就进行插值刷新*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self jg_updateWhenScrollViewDidScroll];
}



@end
