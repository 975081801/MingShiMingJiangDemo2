//
//  GFSSettingCell.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/4.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFSBaseSettingItem;
@interface GFSSettingCell : UITableViewCell
@property(nonatomic,strong)GFSBaseSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
