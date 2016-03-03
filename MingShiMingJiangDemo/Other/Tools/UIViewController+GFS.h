//
//  UIViewController+GFS.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface UIViewController (GFS)
- (void)showsAlertViewWithTitle:(NSString *)title;
- (void)showAlertViewIndeterWith:(SEL)action;
@end
