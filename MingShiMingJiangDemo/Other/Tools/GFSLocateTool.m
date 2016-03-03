//
//  GFSLocateTool.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/1.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSLocateTool.h"
@interface GFSLocateTool()

@property (nonatomic,strong) CLGeocoder *geocoder;

@end
@implementation GFSLocateTool
Singleton_m(GFSLocateTool)
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

//kCLAuthorizationStatusNotDetermined： 用户尚未做出决定是否启用定位服务
//kCLAuthorizationStatusRestricted： 没有获得用户授权使用定位服务
//kCLAuthorizationStatusDenied ：用户已经明确禁止应用使用定位服务或者当前系统定位服务处于关闭状态
//kCLAuthorizationStatusAuthorizedAlways： 应用获得授权可以一直使用定位服务，即使应用不在使用状态
//kCLAuthorizationStatusAuthorizedWhenInUse： 使用此应用过程中允许访问定位服务
- (void)getAuthorization
{
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                break;
                
            case kCLAuthorizationStatusNotDetermined:
                [self.locationManager requestAlwaysAuthorization];
                break;
            case kCLAuthorizationStatusDenied:
                self.unAuthorization = YES;
                break;
            default:
                break;
        }
    }
    
}
- (void)startLocation
{
    [self getAuthorization];
    [self.locationManager startUpdatingLocation];
}
#pragma mark - LocationManager
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//定位精确度
        _locationManager.distanceFilter = 10;//10米定位一次
    }
    return _locationManager;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    //取出经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    _longitude = coordinate.longitude;
    _latitude = coordinate.latitude;
    // 3.打印经纬度
    GFSLog(@"didUpdateLocations------%f %f", coordinate.latitude, coordinate.longitude);
    if (self.locationCompleteBlock) {
        self.locationCompleteBlock(_longitude,_latitude);
    }
    [_locationManager stopUpdatingLocation];//停止定位
}
#pragma mark - 反地理编码

- (void)reverseGeocodeWithlatitude:(CLLocationDegrees )latitude longitude:(CLLocationDegrees)longitude success:(void(^)(NSString *address))success failure:(void(^)())failure
{
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {

        if (error) {
//            GFSLog(@"%@",error.description);
            if (failure) {
                failure();
            }
        } else {
            CLPlacemark *pm = [placemarks firstObject];
            GFSLog(@"%@",pm.locality);
            if (success) {
                success(pm.locality);
            }
        }
    }];
}
#pragma mark - 系统方法计算距离
- (double)countLineDistanceDest:(double)lon1 dest_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2
{
    //计算2个经纬度之间的直线距离
    CLLocation *destloc = [[CLLocation alloc] initWithLatitude:lat1 longitude:lon1];
    CLLocation *selfloc = [[CLLocation alloc] initWithLatitude:lat2 longitude:lon2];
    CLLocationDistance distance = [destloc distanceFromLocation:selfloc];
    return distance;
}

@end
