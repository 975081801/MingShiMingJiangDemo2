//
//  GFSAreaLocationView.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFSAreaLocationView ;
@protocol GFSAreaLocationViewDelegate <NSObject>

@optional
- (void)GPSViewStartLocating;

@end
@interface GFSAreaLocationView : UIView
@property(nonatomic,copy)NSString *selectCity;
@property(nonatomic,weak)id<GFSAreaLocationViewDelegate> delegate;
/**
 *  快速创建一个定位view
 */
+ (instancetype)areaLocationView;
@end
