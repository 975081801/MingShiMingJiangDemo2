//
//  GFSAccount.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSAccount.h"

@implementation GFSAccount
+ (instancetype)account
{
    return [[self alloc]init];
}
/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.pwd = [decoder decodeObjectForKey:@"pwd"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.state = [decoder decodeBoolForKey:@"state"];
    }
    return self;
}
/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.pwd forKey:@"pwd"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.name forKey:@"name"];
    [enCoder encodeBool:self.state forKey:@"state"];
}

@end
