//
//  GFSCity.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFSCity : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *pinyin;
+ (instancetype)city;
@end
