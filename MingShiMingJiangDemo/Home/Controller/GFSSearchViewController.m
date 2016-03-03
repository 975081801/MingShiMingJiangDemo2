//
//  GFSSearchViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/2.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSSearchViewController.h"

@interface GFSSearchViewController ()
/**
 *  无数据时展示
 */
@property(nonatomic,weak)UILabel *noData;
/**
 *  加载的数据
 */
@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation GFSSearchViewController

- (NSMutableArray *)data
{
    if (!_data) {
        NSMutableArray *array = [NSMutableArray array];
        _data = array;
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupBase];
}
- (void)setupBase
{
    NSString *noStr = @"没有数据";
    CGSize labelSize = [noStr sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:30.0] forKey:NSFontAttributeName]];
    CGFloat labelX = ([UIScreen mainScreen].bounds.size.width - labelSize.width) * 0.5;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, 20, labelSize.width, labelSize.height)];
    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor grayColor];
    label.font = [UIFont boldSystemFontOfSize:25.0];
    label.text = noStr;
    label.hidden = self.data.count;
    
    self.noData = label;
    [self.view insertSubview:self.noData aboveSubview:self.tableView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
