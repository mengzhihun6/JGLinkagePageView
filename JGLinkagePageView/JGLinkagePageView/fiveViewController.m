//
//  fiveViewController.m
//  TZtoutiao
//
//  Created by admin on 2017/6/21.
//  Copyright © 2017年 tz. All rights reserved.
//

#import "fiveViewController.h"

@interface fiveViewController ()

@end

@implementation fiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"社会"];
    imageview.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height - 64 -44);
    [self.view addSubview:imageview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
