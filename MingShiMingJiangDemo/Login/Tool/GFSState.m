//
//  GFSState.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/4.
//  Copyright © 2016年 GFS. All rights reserved.
//  记录登录状态

#import "GFSState.h"

@implementation GFSState
Singleton_m(GFSState)
- (instancetype)init
{
    if (self = [super init]) {
        
        // 取出储存的状态
        GFSAccount *account = [GFSAccountTool getAccount];
        
        if (account) {
            self.state = account.state;
        }else
        {
            self.state = NO;
        }
    }
    return self;
}
- (void)setState:(BOOL)state
{
    _state = state;
    
    if ([self.delegate respondsToSelector:@selector(stateChanged:)]) {
        [self.delegate stateChanged:state];
    }

}
@end
