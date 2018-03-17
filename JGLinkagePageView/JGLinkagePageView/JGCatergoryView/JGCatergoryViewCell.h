//
//  JGCatergoryViewCell.h
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JGCatergoryViewCellModel;
@class JGCatergoryViewProperty;

@interface JGCatergoryViewCell : UICollectionViewCell

@property (nonatomic, copy) JGCatergoryViewCellModel *data;
@property (nonatomic, strong) JGCatergoryViewProperty *property;

/**如果使用系统的reloadData会重新prepareLayout，在这里是没必要且耗性能的，所以我们自己提供一个刷新状态的方法*/
- (void)jg_updateCell;

@end
