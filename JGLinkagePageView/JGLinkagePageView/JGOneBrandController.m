//
//  JGOneBrandController.m
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/14.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import "JGOneBrandController.h"

@interface JGOneBrandController ()

@end

@implementation JGOneBrandController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    UIImageView *V = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    V.image = [UIImage imageNamed:@"testTop"];
    [self.view addSubview:V];
    
}

- (void)loadPrandData {
    
    NSLog(@"品牌1数据");
    
    
    
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
