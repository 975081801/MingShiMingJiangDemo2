//
//  GFSBaseSettingItem.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSBaseSettingItem.h"

@implementation GFSBaseSettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    GFSBaseSettingItem *item = [[self alloc]init];
    item.title = title;
    item.icon = icon ;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title
{
    GFSBaseSettingItem *item = [[self alloc]init];
    item.title = title;
    return item;
}
+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title
{
    GFSBaseSettingItem *item = [[self alloc]init];
    item.title = title;
    item.image = image;
    return item;
}
@end
