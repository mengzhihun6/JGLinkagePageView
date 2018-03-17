//
//  JGOneTableView.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGOneTableView.h"

@interface JGOneTableView() <UITableViewDelegate, UITableViewDataSource>

@end


@implementation JGOneTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    [self reloadData];
}


#pragma - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"cell1 - %@ %ld - %ld",self.title, indexPath.section,indexPath.row];
    
    return cell;
}


@end
