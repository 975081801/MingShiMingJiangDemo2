//
//  GFSSetingViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/4.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSSetingViewController.h"
#import "GFSSettingGroup.h"
#import "GFSSettingCell.h"
#import "GFSBaseSettingItem.h"
#import "GFSArrowSettingItem.h"

#import "GFSChangePwdViewController.h"
#import "GFSAdviceViewController.h"
#import "GFSIntroduceViewController.h"
#import "GFSAboutUsViewController.h"

@interface GFSSetingViewController ()
@property(nonatomic,weak)UIView *footer;
@end

@implementation GFSSetingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.hidesBottomBarWhenPushed = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGroup0];
    
    [self setGroup1];
    
    [self setupFooter];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- 私有方法
/**
 *  添加第0组数据
 */
- (void)setGroup0
{
    GFSBaseSettingItem *changePwd = [GFSArrowSettingItem itemWithTitle:@"重置密码" destVcClass:[GFSChangePwdViewController class]];
    
    GFSSettingGroup *group = [[GFSSettingGroup alloc]init];
    group.items = @[changePwd];
    [self.data addObject:group];
}

/**
 *  第1组数据
 */
- (void)setGroup1
{
    GFSBaseSettingItem *advice = [GFSArrowSettingItem itemWithTitle:@"意见反馈" destVcClass:[GFSAdviceViewController class]];
    GFSBaseSettingItem *introduce = [GFSArrowSettingItem itemWithTitle:@"功能介绍" destVcClass:[GFSAdviceViewController class]];
    GFSBaseSettingItem *about = [GFSArrowSettingItem itemWithTitle:@"关于我们" destVcClass:[GFSAdviceViewController class]];
    
    GFSSettingGroup *group = [[GFSSettingGroup alloc]init];
    group.items = @[ advice,introduce,about];
    
    [self.data addObject:group];
}
/**
 *  设置底部按钮
 */
- (void)setupFooter
{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.layer.cornerRadius = 8;
    
    btn.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width- 40, 60);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(signout) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:btn];
    self.footer = footer;
    self.tableView.tableFooterView = footer;
    
}
/**
 *  按钮响应  退出登录
 */
- (void)signout
{
    // 修改登录状态 退出登录
    GFSAccount *account = [GFSAccountTool getAccount];
    
    account.state = NO;
    
    [GFSAccountTool saveAccount:account];
    
    [GFSState sharedGFSState].state = NO;
}
#pragma mark- tableView代理和数据源

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc]init];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.layer.cornerRadius = 8;
    
    btn.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width- 40, 60);
    [footer addSubview:btn];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
