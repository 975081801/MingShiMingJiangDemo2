//
//  GFSNavigationController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSNavigationController.h"
#import "GFSMeViewController.h"
#import "GFSLoginViewController.h"
@interface GFSNavigationController ()

@end

@implementation GFSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    // 2.设置导航栏按钮主题；
    [self setupNavBarButtonTheme];
}
+ (void)setupNavBarButtonTheme
{
    // 获取当前按钮
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc]init];
    //
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14.0];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, 0);
    shadow.shadowBlurRadius = 0;
    textAttrs[NSShadowAttributeName] = shadow;
    
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

+ (void)setupNavBarTheme
{
    // 取出当前的navBar对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor blackColor];
    // 设置透明
//    navBar.alpha = 1;
    [navBar setTranslucent:YES];
//    [navBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[[UIImage alloc]init] ];
//    navBar.backgroundColor = [UIColor clearColor];
    // 设置标题属性
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc]init];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    // 阴影设置
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, 0);
    shadow.shadowBlurRadius = 0;
    textAttrs[NSShadowAttributeName] = shadow;
    
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19.0];
    [navBar setTitleTextAttributes:textAttrs];
}

/**
 *  重写push方法  拦截底部导航栏
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 为防止拦截自己的rootViewcontroller 加以判断
    if (self.viewControllers.count > 0) {
        // 设置底部导航不显示
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
//    if ([viewController isKindOfClass:[GFSMeViewController class]]) {
//        viewController.hidesBottomBarWhenPushed = NO;
//    }
//    if ([viewController isKindOfClass:[GFSLoginViewController class]]) {
//        viewController.hidesBottomBarWhenPushed = NO;
//    }
    [super pushViewController:viewController animated:animated];
}

@end
