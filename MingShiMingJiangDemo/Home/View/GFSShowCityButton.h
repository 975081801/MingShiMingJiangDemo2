//
//  GFSShowCityButton.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/1.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface GFSShowCityButton : UIButton
Singleton_h(GFSShowCityButton)
@property(nonatomic,copy)NSString *cityName;
@end
