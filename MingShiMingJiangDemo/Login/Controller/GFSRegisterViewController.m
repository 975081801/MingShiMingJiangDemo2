//
//  GFSRegisterViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSRegisterViewController.h"
#import "GFSSendChechCodeButton.h"
#import "GFSLoginViewController.h"
@interface GFSRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet GFSSendChechCodeButton *senCheckBtn;
- (IBAction)sendCheckMessage:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *checkCode;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
- (IBAction)soundCheckMode:(id)sender;
- (IBAction)doneRegister:(id)sender;
- (IBAction)loginBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@end

@implementation GFSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.phoneNumber becomeFirstResponder];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneNumber];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.checkCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)init
{
    if (self = [super init]) {
        
        [self setup];
    }
    return self;
}
- (void)awakeFromNib
{
    [self setup];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self setup];
}
- (void)setup
{
    // 初始化动作
}
- (void)textChange
{
    // 文本框内输入有文字（长度不为0）
    self.doneBtn.enabled = (self.phoneNumber.text.length && self.pwdField.text.length&&self.checkCode.text.length);
}
- (IBAction)sendCheckMessage:(id)sender {
    
}
- (IBAction)soundCheckMode:(UIButton *)sender {
    
    sender.enabled = NO;
    
    self.tipLabel.text = @"电话拨打中。。。请等待";
#warning 这里应该进行发送当前号码  进行回拨
}

- (IBAction)doneRegister:(id)sender
{
    
    
}

- (IBAction)loginBtn:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
