//
//  JGCatergoryViewCellModel.h
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGCatergoryViewCellModel : NSObject

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) CGFloat valueRatio;
@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, assign) CGPoint cellCenter;
@property (nonatomic, assign,readonly) CGRect cellFrame;
@property (nonatomic, assign, readonly) CGRect backEllipseFrame;

@end
