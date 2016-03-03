//
//  GFSShowCityButton.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/1.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSShowCityButton.h"

@implementation GFSShowCityButton
Singleton_m(GFSShowCityButton)
- (void)setHighlighted:(BOOL)highlighted
{
    
}

/**
 *  重写setter  封装保存使用城市记录
 */
- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
    
    //存储数据
    [[NSUserDefaults  standardUserDefaults]setObject:cityName forKey:@"city"];

    [[NSUserDefaults  standardUserDefaults]synchronize];
    
    if (cityName.length > 3) {
        NSString *miniName = [cityName substringToIndex:3];
        
        [self setTitle:miniName forState:UIControlStateNormal];
    }else{
        [self setTitle:cityName forState:UIControlStateNormal];
    }
}
@end
