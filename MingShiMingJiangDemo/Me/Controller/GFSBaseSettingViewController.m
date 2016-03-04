//
//  GFSBaseSettingViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/4.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSBaseSettingViewController.h"
#import "GFSSettingGroup.h"
#import "GFSSettingCell.h"
#import "GFSBaseSettingItem.h"
#import "GFSArrowSettingItem.h"
#import "GFSSwithSettingItem.h"
@interface GFSBaseSettingViewController ()

@end

@implementation GFSBaseSettingViewController

#pragma mark- 初始化
- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array] ;
    }
    return _data;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GFSSettingGroup *group = self.data[section];
    return group.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFSSettingCell *cell = [GFSSettingCell cellWithTableView:tableView];
    //    cell.item = self.data[indexPath.section][indexPath.row];
    GFSSettingGroup *group = self.data[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    return cell ;
}
#pragma mark- tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //2.模型数据
    
    GFSSettingGroup *group = self.data[indexPath.section];
    GFSBaseSettingItem *item = group.items[indexPath.row];
    if (item.option) {// block有值(点击这个cell,.有特定的操作需要执行)
        item.option();
    }else if([item isKindOfClass:[GFSArrowSettingItem class]]) {// 箭头
        
        //判断有没有要跳转的控制器
        
        GFSArrowSettingItem *arrowitem = (GFSArrowSettingItem *)item;
        if (arrowitem.destinationVcClass == nil) return;
        
        UIViewController *vc = [[arrowitem.destinationVcClass alloc]init];
        // 设置控制器标题
        
        vc.title = arrowitem.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景要先清空背景View 其优先级高于backgroundcolor，grouped样式采用会有backgroundView
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.backgroundColor = GFSColor(217, 217, 217, 0.8);
}

@end
