//
//  GFSArrowSettingItem.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSArrowSettingItem.h"

@implementation GFSArrowSettingItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destinationVcClass
{
    GFSArrowSettingItem *item = [self itemWithIcon:icon title:title];
    item.destinationVcClass = destinationVcClass;
    
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destinationVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destinationVcClass];
}

@end
