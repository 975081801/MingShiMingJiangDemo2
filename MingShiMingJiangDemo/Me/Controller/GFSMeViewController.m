//
//  GFSMeViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSMeViewController.h"
#import "GFSSetingViewController.h"
#import "GFSPreviewController.h"

#import "GFSSettingGroup.h"
#import "GFSSettingCell.h"
#import "GFSBaseSettingItem.h"
#import "GFSArrowSettingItem.h"
#import "GFSSwithSettingItem.h"

#import "GFSIDinfoViewController.h"
#import "GFSWorkNoteViewController.h"
#import "GFSWorksModelViewController.h"
#import "GFSMyHeaderView.h"
@interface GFSMeViewController ()
@property(nonatomic,weak)GFSMyHeaderView *header;
@end

@implementation GFSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = GFSColor(230, 230, 230, 0.8);
    
    GFSMyHeaderView *header = [[GFSMyHeaderView alloc]init];
    
    header.backgroundColor = [UIColor greenColor];
    header.frame = CGRectMake(0, 0, 0, 200);
    self.tableView.tableHeaderView = header;
    self.header = header;
    [self setGroup0];
    
    [self setGroup1];
}
/**
 *  添加第0组数据
 */
- (void)setGroup0
{
    GFSBaseSettingItem *IDinfo = [GFSArrowSettingItem itemWithIcon:@"IDInfo"  title:@"个人信息" destVcClass:[GFSIDinfoViewController class]];
    GFSBaseSettingItem *workNote = [GFSArrowSettingItem itemWithIcon:@"workNote" title:@"接活信息" destVcClass:[GFSWorkNoteViewController class]];
    GFSBaseSettingItem *Models = [GFSArrowSettingItem itemWithIcon:@"Models" title:@"作品案例" destVcClass:[GFSWorksModelViewController class]];
    
    GFSSettingGroup *group = [[GFSSettingGroup alloc]init];
    
    group.items = @[IDinfo, workNote, Models];
    
    [self.data addObject:group];
}
/**
 *  第1组数据
 */
- (void)setGroup1
{
    GFSBaseSettingItem *phoneNumShow = [GFSSwithSettingItem itemWithTitle:@"是否显示电话"];
    GFSBaseSettingItem *applyForWork = [GFSSwithSettingItem itemWithTitle:@"我要求职"];
    GFSBaseSettingItem *enlightening = [GFSSwithSettingItem itemWithTitle:@"我要收徒"];
    GFSBaseSettingItem *haveTimeForWork = [GFSSwithSettingItem itemWithTitle:@"我有时间接业务"];
    
    GFSSettingGroup *group = [[GFSSettingGroup alloc]init];
    group.items = @[ phoneNumShow ,applyForWork,enlightening,haveTimeForWork];
    
    [self.data addObject:group];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
