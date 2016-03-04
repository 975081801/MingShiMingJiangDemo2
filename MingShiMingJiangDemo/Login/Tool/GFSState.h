//
//  GFSState.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/4.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@protocol GFSStateDelegate <NSObject>

@optional
- (void)stateChanged:(BOOL)state;

@end
@interface GFSState : NSObject
Singleton_h(GFSState)
@property(nonatomic,assign)BOOL state;
@property(nonatomic,weak)id<GFSStateDelegate> delegate;
@end
