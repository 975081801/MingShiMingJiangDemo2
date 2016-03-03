//
//  UIBarButtonItem+GFS.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "UIBarButtonItem+GFS.h"

@implementation UIBarButtonItem (GFS)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = (CGRect){CGPointZero ,button.currentBackgroundImage.size};
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
