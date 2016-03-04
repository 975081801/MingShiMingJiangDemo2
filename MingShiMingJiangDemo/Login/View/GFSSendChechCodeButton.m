//
//  GFSSendChechCodeButton.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSSendChechCodeButton.h"

@interface GFSSendChechCodeButton()
/** 保存倒计时按钮的非倒计时状态的title */
@property (nonatomic, copy) NSString *originalTitle;
/** 保存倒计时的时长 */
@property (nonatomic, assign) NSInteger tempDurationOfCountDown;
/** 定时器对象 */
@property (nonatomic, strong) NSTimer *countDownTimer;
@end

@implementation GFSSendChechCodeButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 5;
        // 设置默认的倒计时时长为60秒
        self.durationOfCountDown = 60;
        // 设置button的默认标题为“获取验证码”
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // 设置默认的倒计时时长为60秒
        self.durationOfCountDown = 60;
        // 设置button的默认标题为“获取验证码”
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}
- (void)awakeFromNib
{
    // 设置默认的倒计时时长为60秒
    self.durationOfCountDown = 60;
    // 设置button的默认标题为“获取验证码”
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];

}
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    // 倒计时过程中title的改变不更新originalTitle
    if (self.tempDurationOfCountDown == self.durationOfCountDown) {
        self.originalTitle = title;
    }
}
- (void)setDurationOfCountDown:(NSInteger)durationOfCountDown {
    _durationOfCountDown = durationOfCountDown;
    self.tempDurationOfCountDown = _durationOfCountDown;
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // 若正在倒计时，不响应点击事件
    if (self.tempDurationOfCountDown != self.durationOfCountDown) {
        return NO;
    }
    // 若未开始倒计时，响应并传递点击事件，开始倒计时
    [self startCountDown];
    return [super beginTrackingWithTouch:touch withEvent:event];
}
- (void)startCountDown {
    // 创建定时器
    self.countDownTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateIDCountDownButtonTitle) userInfo:nil repeats:YES];
    // 将定时器添加到当前的RunLoop中（自动开启定时器）
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
}
- (void)updateIDCountDownButtonTitle {
    if (self.tempDurationOfCountDown == 0) {
        // 设置IDCountDownButton的title为开始倒计时前的title
        [self setTitle:self.originalTitle forState:UIControlStateNormal];
        // 恢复IDCountDownButton开始倒计时的能力
        self.tempDurationOfCountDown = self.durationOfCountDown;
        [self.countDownTimer invalidate];
    } else {
        // 设置IDCountDownButton的title为当前倒计时剩余的时间
        [self setTitle:[NSString stringWithFormat:@"%zd秒", self.tempDurationOfCountDown--] forState:UIControlStateNormal];
    }
}
- (void)dealloc {
    
    [self.countDownTimer invalidate];
}
@end
