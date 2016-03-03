//
//  GFSArrowSettingItem.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//  点击后需要跳转的cell

#import "GFSBaseSettingItem.h"

@interface GFSArrowSettingItem : GFSBaseSettingItem
/**
 *  cell即将跳转的控制器类
 */
@property(nonatomic,assign)Class destinationVcClass;
/**
 *  有图片的
 */
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destinationVcClass;
/**
 *  无图片的
 *
 */
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destinationVcClass;

@end
