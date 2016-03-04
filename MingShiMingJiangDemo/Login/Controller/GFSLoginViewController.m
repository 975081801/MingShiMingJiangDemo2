//
//  GFSLoginViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSLoginViewController.h"
#import "GFSRegisterViewController.h"
#import "GFSMeViewController.h"
#import "GFSRemindViewController.h"
#import "GFSMeNavigationController.h"

@interface GFSLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *scretCode;
- (IBAction)loginBtn:(UIButton *)sender;
- (IBAction)remindBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation GFSLoginViewController

#pragma mark- lifeCycle
- (void)awakeFromNib
{
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.clipsToBounds = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToRegisterVc)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneNumber];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.scretCode];
}
- (void)dealloc
{
    // 有接受通知  必须要有移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark- privateMethods
/**
 *  文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    // 文本框内输入有文字（长度不为0）
    //    self.LoginBtn.enabled = YES ;
    self.loginBtn.enabled = (self.phoneNumber.text.length && self.scretCode.text.length);
}
#pragma mark- event反馈
- (IBAction)loginBtn:(UIButton *)sender {
//
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
#warning 本应该是联网判断
    if (![self.phoneNumber.text isEqualToString:@"12345678901"]) {
        // 账号错误时 弹窗提示（第三方库）
        hud.labelText = @"账号不存在";
        [hud hide:YES];
        return;// 直接返回
    }
    if (![self.scretCode.text isEqualToString:@"123456"]) {
        // 密码错误是 弹窗提示
        hud.labelText = @"密码错误";
        [hud hide:YES];
        return;
    }
    // 显示一个蒙版(遮盖)
    hud.labelText = @"管哥正在帮你登陆";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 隐藏遮盖
        [hud hide:YES];
        // 存储登录账户
        GFSAccount *account = [GFSAccount account];
        
        account.uid = self.phoneNumber.text;
        account.pwd = self.scretCode.text;
        
        account.state = YES;
        
        
        [GFSAccountTool saveAccount:account];
        
        [GFSState sharedGFSState].state = YES;
        
    });

}
- (void)jumpToRegisterVc
{
    GFSRegisterViewController *registerVc = [[GFSRegisterViewController alloc]init];
    registerVc.title = @"注册";
    [self.navigationController pushViewController:registerVc animated:YES];
}
- (IBAction)remindBtn:(UIButton *)sender
{
    GFSRemindViewController *remindVc = [[GFSRemindViewController alloc]init];
    remindVc.title = @"密码重置";
    
    [self.navigationController pushViewController:remindVc animated:YES];
}
@end
