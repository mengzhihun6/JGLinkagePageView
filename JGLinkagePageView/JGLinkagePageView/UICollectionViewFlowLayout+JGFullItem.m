//
//  UICollectionViewFlowLayout+JGFullItem.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "UICollectionViewFlowLayout+JGFullItem.h"
#import <objc/runtime.h>

@implementation UICollectionViewFlowLayout (JGFullItem)

- (void)setFullItem:(BOOL)fullItem{
    objc_setAssociatedObject(self, "fullItem", @(fullItem), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)fullItem{
    return [objc_getAssociatedObject(self, "fullItem") intValue];
}

- (void)prepareLayout{
    if (self.fullItem) {
        self.itemSize = self.collectionView.bounds.size;
    }
    [super prepareLayout];
}

@end
