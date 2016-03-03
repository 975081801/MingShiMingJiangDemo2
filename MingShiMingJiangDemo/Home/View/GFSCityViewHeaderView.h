//
//  GFSCityViewHeaderView.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFSCityViewHeaderView,GFSAreaLocationView;
@protocol GFSCityViewHeaderViewDelegate <NSObject>

@optional
- (void)hotCityClicked:(GFSCityViewHeaderView *)headerView city:(NSString *)cityName;

@end
@interface GFSCityViewHeaderView : UIView
/**
 *  headerView的高度
 */
@property(nonatomic,assign)CGFloat headerViewHeight;
/**
 *  定位
 */
@property(nonatomic,weak)GFSAreaLocationView *areaView;
@property(nonatomic,weak)id<GFSCityViewHeaderViewDelegate> delegate;
+ (instancetype)header;
@end
