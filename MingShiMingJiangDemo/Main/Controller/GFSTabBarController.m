//
//  GFSTabBarController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSTabBarController.h"
#import "GFSMeViewController.h"
#import "GFSMessageViewController.h"
#import "GFSHomeCollectionViewController.h"
#import "GFSNavigationController.h"
#import "GFSLoginViewController.h"
#import "GFSMeNavigationController.h"

@interface GFSTabBarController ()

@end

@implementation GFSTabBarController

#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    [self setupChildViewControllers];
}
#pragma mark- privateMothods
/**
 *  设置所有子控制器
 */
- (void)setupChildViewControllers
{
    /*
     多个控制器创建同样方式  可以抽出一个方法  传入相应参数
     */
    // 1.首页
    GFSHomeCollectionViewController *home = [[GFSHomeCollectionViewController  alloc]init];
    [self setupChildViewController:home withTitle:@"首页" imageName:@"" selectedImageName:@""];
    // 2.消息
    GFSMessageViewController *message = [[GFSMessageViewController alloc]init];
    [self setupChildViewController:message withTitle:@"消息" imageName:@"" selectedImageName:@""];
    // 3. 我
    [self setMe];
}
- (void)setMe
{
       // 取出保存的账户
    GFSAccount *account = [GFSAccountTool getAccount];
    if (account) {
        // 有
        if (account.state) {
            // 是登录状态
#warning 应该在此时传入 保存的信息
            GFSMeViewController *me = [[GFSMeViewController alloc]init];
            GFSMeNavigationController *meNav = [[GFSMeNavigationController alloc]initWithRootViewController:me];

             [self addChildViewController:meNav];
        }else{
            GFSLoginViewController *log = [[GFSLoginViewController alloc]init];
#warning 传入保存的账号和密码 不用再次输入
            GFSMeNavigationController *meNav = [[GFSMeNavigationController alloc]initWithRootViewController:log];
            [self addChildViewController:meNav];
        }
        
    }else{
        GFSLoginViewController *log = [[GFSLoginViewController alloc]init];
        GFSMeNavigationController *meNav = [[GFSMeNavigationController alloc]initWithRootViewController:log];
        [self addChildViewController:meNav];
    }
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           自控制器
 *  @param title             标题
 *  @param imageName         图片名
 *  @param selectedImageName 选中图片名
 */
- (void)setupChildViewController:(UIViewController *)childVc withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1. 设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 选中图标
    UIImage *selectedImage = [UIImage imageWithName: selectedImageName];
    
    if (iOS7) {
        // 不让系统自动渲染
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    }
    // 2. 包装导航
    UINavigationController *nav = [[GFSNavigationController alloc]initWithRootViewController:childVc];
    // 3. 添加到tabBar
    [self addChildViewController:nav];
    
}
#pragma mark-代理方法

@end
