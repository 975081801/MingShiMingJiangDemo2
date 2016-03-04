//
//  GFSMineViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/4.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSMineViewController.h"
#import "GFSMeViewController.h"
#import "GFSLoginViewController.h"
#import "GFSSetingViewController.h"
#import "GFSRegisterViewController.h"
#import "GFSPreviewController.h"
@interface GFSMineViewController ()<GFSStateDelegate>
/**
 *  记录登录状态
 */
@property(nonatomic,strong)GFSState *state;

@end

@implementation GFSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.state = [GFSState sharedGFSState];
    self.state.delegate = self;
    // 添加子控制器
    [self addChildViewControllers];
    // 设置显示的控制器
    [self showWhichViewController];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- 状态改变代理方法
- (void)stateChanged:(BOOL)state
{
    if (state) {
        
        [UIView animateWithDuration:0.2 animations:^{
            // 显示wo模块
            [self showMyView];
        } completion:nil];
        
    }else{
        // 显示登录界面
        [self showLoginView];
    }
}
#pragma mark- 私有方法
- (void)addChildViewControllers
{
    
    GFSMeViewController *me = [[GFSMeViewController alloc]init];
    
    me.view.frame = self.view.bounds;
    [self addChildViewController:me];
    
    GFSLoginViewController *log = [[GFSLoginViewController alloc]init];
    
    log.view.frame = self.view.bounds;
#warning 传入保存的账号和密码 不用再次输入
    
    [self addChildViewController:log];
    
}
/**
 *  跳转预览界面
 */
- (void)junmpToPreview
{
#warning 出入数据
    GFSPreviewController *preVc = [[GFSPreviewController alloc]init];
    
    [self.navigationController pushViewController:preVc animated:YES];
}
/**
 *  跳转到设置模块
 */
- (void)jumpToSettings
{
    GFSSetingViewController *setVc = [[GFSSetingViewController alloc]init];
    [self.navigationController pushViewController:setVc animated:YES];
}
/**
 *  跳转到注册模块
 */
- (void)jumpToRegisterVc
{
    GFSRegisterViewController *registerVc = [[GFSRegisterViewController alloc]init];
    registerVc.title = @"注册";
    [self.navigationController pushViewController:registerVc animated:YES];
}
/**
 *  开始加载时根据登录状态 选择
 */
- (void)showWhichViewController
{
    GFSAccount *account = [GFSAccountTool getAccount];
    
    if (account) {
        if (account.state) {
            // 显示wo模块
            [self showMyView];
            
        }else{
            // 显示登录界面
            [self showLoginView];
        }
            
    }else{
        [self showLoginView];
    }
}
/**
 *  显示wo模块
 */
- (void)showMyView
{
    // 显示wo模块
    self.title = @"我的";
    GFSLoginViewController *hideVC = self.childViewControllers[1];
    
    [hideVC.view removeFromSuperview];
    
    GFSMeViewController *showVC = self.childViewControllers[0];
    
    [self.view addSubview:showVC.view];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:@"预览" style:UIBarButtonItemStyleDone target:self action:@selector(junmpToPreview)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc ]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(jumpToSettings)];
}
/**
 *  显示登录界面
 */
- (void)showLoginView
{
    // 显示登录界面
    self.title = @"登录";
    GFSMeViewController *hideVC = self.childViewControllers[0];
    
    [hideVC.view removeFromSuperview];
    
    GFSLoginViewController *showVC = self.childViewControllers[1];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.view addSubview:showVC.view];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToRegisterVc)];
}


@end
