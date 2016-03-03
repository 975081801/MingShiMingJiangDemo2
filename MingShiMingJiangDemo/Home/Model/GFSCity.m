//
//  GFSCity.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSCity.h"
#import "ChineseToPinyin.h"
@implementation GFSCity

- (void)setName:(NSString *)name
{
    _name = name;
    _pinyin = [ChineseToPinyin pinyinFromChiniseString:name];
//    _pinyin = [NSString pinYinStringFromChinese:name];
}
+ (instancetype)city
{
    return [[GFSCity alloc]init];
}
@end
