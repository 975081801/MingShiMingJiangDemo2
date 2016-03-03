//
//  GFSLocateTool.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/1.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface GFSLocateTool : NSObject<CLLocationManagerDelegate>
Singleton_h(GFSLocateTool)
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic,assign) double longitude;//经度
@property (nonatomic,assign) double latitude;//纬度
@property(nonatomic,assign,getter=isUnAuthorization)BOOL unAuthorization;
//定位结束的回调
@property (nonatomic,strong) void(^locationCompleteBlock)(double longitude,double latitude);
- (void)getAuthorization;//授权
//- (void)alertOpenLocationSwitch;//提示用户打开定位开关
- (void)startLocation;//点击某个按钮开始定位
/**
 *  反地理编码 （通过经纬度获取地址）
 *
 *  @param latitude      输入的纬度
 *  @param longitude     输入经度
 *  @param success       成功block，返回pm
 *  @param failure       失败block
 */
- (void)reverseGeocodeWithlatitude:(CLLocationDegrees )latitude longitude:(CLLocationDegrees)longitude success:(void(^)(NSString *address))success failure:(void(^)())failure;
/**
 *  经纬度计算两地之间距离
 *
 *  @param lon1      目标的的经度
 *  @param lat1      目标的纬度
 *  @param lon2      自己的经度
 *  @param lat2      自己的纬度
 *  @param 返回值     距离（米）
 */
-(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;
@end
