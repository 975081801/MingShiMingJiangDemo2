//
//  UIBarButtonItem+GFS.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GFS)
/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
