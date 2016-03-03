//
//  GFSTableViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSTableViewController.h"
#import "MJRefresh.h"

@interface GFSTableViewController ()

@end

@implementation GFSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
/**
 *  添加刷新控件
 */
- (void)setupRefreshView
{
    // 下拉刷新
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    [header setTitle:@"下拉可以刷新了" forState:MJRefreshStateIdle];
    [header setTitle:@"松开马上刷新了" forState:MJRefreshStatePulling];
    [header setTitle:@"管哥正在帮你刷新中,不客气" forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView.mj_header beginRefreshing];
    // 上啦刷新
    self.tableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
//- (void)alertShow
//{
//    [self showAlertViewIndeterWith:@selector(loadNewData)];
//}
/**
 *  可在此方法内进行下拉刷新动作  子类可覆盖此方法
 */
- (void)loadNewData
{
    // 一般要进行请求参数对比 加载最新的
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    });
}
/**
 *  可在此方法内进行上拉加载动作  子类可覆盖此方法
 */
- (void)loadMoreData
{
    // 一般要进行请求参数对比 加载最新的
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
