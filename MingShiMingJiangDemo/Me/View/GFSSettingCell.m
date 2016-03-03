//
//  GFSSettingCell.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/4.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSSettingCell.h"
#import "GFSBaseSettingItem.h"
#import "GFSArrowSettingItem.h"
#import "GFSSwithSettingItem.h"


@interface GFSSettingCell()
/**
 *  开关
 */
@property(nonatomic,strong)UISwitch *switchView;
/**
 *  文本
 */
@property(nonatomic,strong)UILabel *labelView;
/**
 *  箭头，虽然是控件类型，但用strong保存  随cell存在 而且系统调用次数多 采用懒加载
 */
@property(nonatomic,strong)UIImageView *arrowView;

@end
@implementation GFSSettingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    GFSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[GFSSettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化操作
        // 设置选中后的背景
        UIView *selectedBg = [[UIView alloc]init];
        selectedBg.backgroundColor   = [UIColor colorWithRed:237/255.0 green:233/255.0 blue:218/255.0 alpha:1.0];
        
        self.selectedBackgroundView = selectedBg;
    }
    return self;
}

- (void)setItem:(GFSBaseSettingItem *)item
{
    _item = item ;
    //1.设置数据
    [self setUpData];
    //2.设置右边显示内容
    [self setUpRightContent];
}
- (void)setUpData
{
    //先判断是不是有图片 如果有添加到imageview
    if (self.item.icon) {
        
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    self.textLabel.text = self.item.title;
    self.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    self.detailTextLabel.text = self.item.subTitle;
}
- (void)setUpRightContent
{
    if ([self.item isKindOfClass:[GFSArrowSettingItem class]]) {
        // 设置箭头
        self.accessoryView = self.arrowView;
        // cell的循环利用   改过的状态要改回去
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else if([self.item isKindOfClass:[GFSSwithSettingItem class]]){
        
        self.accessoryView = self.switchView;
        // 设置开关的状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
#warning 此处应该也是更改状态后发送请求
        self.switchView.on = [defaults  boolForKey:self.item.title];
        //取消选中效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else {
        // 由于循环利用，如果没有右侧内容应清空
        self.accessoryView = nil;
    }
}
- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc]init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}
- (void)switchStateChange
{
    // 获取单例对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 存储开关状态  键值对与标题关联
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    // 刷新数据
    [defaults synchronize];
}
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        //        UIImageView *img = [[UIImageView alloc]init];
        //        img.image = [UIImage imageNamed:@"CellArrow"];
        //        _arrowView = img;
        // 直接以图片尺寸
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowView;
}
- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc]init];
        _labelView.bounds = CGRectMake(0, 0, 100, 30);
        _labelView.backgroundColor = [UIColor redColor];
    }
    return _labelView;
}

- (void)setFrame:(CGRect)frame
{
    // 此处可修改尺寸
    [super setFrame:frame];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
