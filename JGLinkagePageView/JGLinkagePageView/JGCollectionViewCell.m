//
//  JGCollectionViewCell.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGCollectionViewCell.h"
#import "Masonry.h"
#import "JGOneTableView.h"

@interface JGCollectionViewCell () 
@property (nonatomic, weak) UILabel *label;

@property (nonatomic, strong) JGOneTableView *tableView;

@end

@implementation JGCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        _tableView = [[JGOneTableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height) style:UITableViewStylePlain];
        
        [self.contentView addSubview:_tableView];
        
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
        
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    _tableView.title = title;
       
}




@end
