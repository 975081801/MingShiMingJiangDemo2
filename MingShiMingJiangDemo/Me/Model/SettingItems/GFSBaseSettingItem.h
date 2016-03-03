//
//  GFSBaseSettingItem.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//  最基础的cell展现

#import <Foundation/Foundation.h>

typedef void (^GFSSettingItemOptions)();
@interface GFSBaseSettingItem : NSObject
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;
/**++
 *  图片
 */
@property(nonatomic,copy)NSString *icon;
/**
 *  小标题
 */
@property(nonatomic,copy)NSString *subTitle;
/**
 *  点击那个cell需要做什么事
 */
@property(nonatomic,copy)GFSSettingItemOptions option;
/**
 *  带头像的
 */
@property(nonatomic,copy)NSString *image;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title;
@end
