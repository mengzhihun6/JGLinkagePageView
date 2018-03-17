//
//  JGBaseViewController.h
//  JGPageViewDemo
//
//  Created by 郭军 on 2018/3/10.
//  Copyright © 2018年 JUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UIViewController+JGPopBlock.h"

@interface JGBaseViewController : UIViewController

@property (nonatomic,strong) MBProgressHUD* hud;
/**
 在VC的view上加HUD，
 
 @param msg 显示的文本，nil为不显示任何文本
 */
- (void)showHUDToViewMessage:(NSString *)msg;

- (void)showHUDToWindowMessage:(NSString *)msg;

- (void)removeHUD;

@end
