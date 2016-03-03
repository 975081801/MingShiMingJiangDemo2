//
//  GFSCollectionReusableView.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/2.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^myBlock)(NSString *type);回调不好用

@class GFSCollectionReusableView;
@protocol GFSCollectionReusableViewDelegate <NSObject>

@optional
- (void)headerView:(GFSCollectionReusableView *)headerView clicked:(NSString *)partType;

@end
@interface GFSCollectionReusableView : UICollectionReusableView
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,weak)id<GFSCollectionReusableViewDelegate> delegate;
@end
