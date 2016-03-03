//
//  GFSAccountTool.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFSAccount.h"
@interface GFSAccountTool : NSObject
/**
 *  存储account
 *
 *  @param account 需要储存的account
 */
+ (void)saveAccount:(GFSAccount *)account;
/**
 *  取出account
 *
 *  @return 存储的account
 */
+ (GFSAccount *)getAccount;
@end
