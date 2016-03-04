//
//  GFSMineViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/4.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSMineViewController.h"
#import "GFSMeNavigationController.h"
#import "GFSMeViewController.h"
#import "GFSLoginViewController.h"
@interface GFSMineViewController ()<GFSStateDelegate>
/**
 *  记录登录状态
 */
@property(nonatomic,strong)GFSState *state;;
/**
 *  记录当前展示的控制器
 */
@property(nonatomic,weak)UIViewController *showViewController;

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
- (void)addChildViewControllers
{
    
    GFSMeViewController *me = [[GFSMeViewController alloc]init];
    
    GFSMeNavigationController *meNav = [[GFSMeNavigationController alloc]initWithRootViewController:me];
    [self addChildViewController:meNav];
    
    GFSLoginViewController *log = [[GFSLoginViewController alloc]init];
    
#warning 传入保存的账号和密码 不用再次输入
    GFSMeNavigationController *logNav = [[GFSMeNavigationController alloc]initWithRootViewController:log];
    [self addChildViewController:logNav];
    
   
}

- (void)stateChanged:(BOOL)state
{
    if (state) {
        
        // 显示wo模块
        GFSMeNavigationController *hideVC = self.childViewControllers[1];
        
        [hideVC.view removeFromSuperview];
        
        GFSMeNavigationController *showVC = self.childViewControllers[0];
        
        [self.view addSubview:showVC.view];
        
    }else{
        GFSMeNavigationController *hideVC = self.childViewControllers[0];
        
        [hideVC.view removeFromSuperview];
        
        GFSMeNavigationController *showVC = self.childViewControllers[1];
        
        [self.view addSubview:showVC.view];
    }
}
- (void)showWhichViewController
{
    GFSAccount *account = [GFSAccountTool getAccount];
    
    if (account) {
        if (account.state) {
            
            // 显示wo模块
            GFSMeNavigationController *hideVC = self.childViewControllers[1];
            
            [hideVC.view removeFromSuperview];
            
            GFSMeNavigationController *showVC = self.childViewControllers[0];
            
            [self.view addSubview:showVC.view];
//            self.showViewController = self.mineVC;
        }else{
            
            GFSMeNavigationController *hideVC = self.childViewControllers[0];
            
            [hideVC.view removeFromSuperview];
            
            GFSMeNavigationController *showVC = self.childViewControllers[1];
            
            [self.view addSubview:showVC.view];
        }
            
    }else{
        
        GFSMeNavigationController *hideVC = self.childViewControllers[0];
        
        [hideVC.view removeFromSuperview];
        
        GFSMeNavigationController *showVC = self.childViewControllers[1];
        
        [self.view addSubview:showVC.view];
    }
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
