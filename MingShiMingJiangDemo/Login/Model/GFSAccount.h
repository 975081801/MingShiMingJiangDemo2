//
//  GFSAccount.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFSAccount : NSObject<NSCoding>
/**
 *  user ID
 */
@property(nonatomic,copy)NSString *uid;
/**
 *  密码（一般用MD5加盐加密）
 */
@property(nonatomic,copy)NSString *pwd;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  记录状态 是否登录状态  （登出时修改为NO）
 */
@property(nonatomic,assign)BOOL state;
#warning 后续可能保存的更多比如 用户信息  暂时这样
+ (instancetype)account;
@end
