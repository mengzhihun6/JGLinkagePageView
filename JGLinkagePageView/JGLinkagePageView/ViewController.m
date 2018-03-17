//
//  ViewController.m
//  JGLinkagePageView
//
//  Created by 郭军 on 2018/3/17.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联动";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    
    
}

- (NSArray *)data{
    if (!_data) {
        _data = @[@"颜色左右渐变 + 底部线条", @"颜色变化 + 背后椭圆", @"颜色变化 + 文字缩放 + 模拟网络刷新",@"仿网易 + 文字放大",@"背景透明 + 底部线条"];
    }
    return _data;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *names =  @[@"JGOneController", @"JGTwoController", @"JGThreeController",@"JGFourController",@"JGFiveController"];
    UIViewController *vc = [[NSClassFromString(names[indexPath.row]) alloc] init];
    vc.title = _data[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
