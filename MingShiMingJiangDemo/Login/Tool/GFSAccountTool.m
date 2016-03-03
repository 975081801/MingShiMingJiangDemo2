//
//  GFSAccountTool.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSAccountTool.h"


#define GFSAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation GFSAccountTool

+ (void)saveAccount:(GFSAccount *)account
{
    
    [NSKeyedArchiver archiveRootObject:account toFile:GFSAccountFile];
}
+ (GFSAccount *)getAccount
{
        // 取出账号
    GFSAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:GFSAccountFile];
    // 判断账号授权是否过期
    return account;
}

@end
