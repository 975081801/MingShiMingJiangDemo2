//
//  GFSCityViewHeaderView.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSCityViewHeaderView.h"
#import "GFSAreaLocationView.h"

#define GFSHeaderBoarder 8
@interface GFSCityViewHeaderView()
/**
 *  热门城市
 */
@property(nonatomic,weak)UILabel *hotLabel;
/**
 *  热门城市按钮组
 */
@property(nonatomic,strong)NSMutableArray *hotcities;

@end
@implementation GFSCityViewHeaderView

+ (instancetype)header
{
    return [[GFSCityViewHeaderView alloc]init];
}
- (NSMutableArray *)hotcities
{
    if (!_hotcities) {
        _hotcities = [NSMutableArray array];
    }
    return _hotcities;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = GFSColor(215, 215, 215, 1);
        self.userInteractionEnabled = YES;
        // 定位View
        GFSAreaLocationView *areaView = [GFSAreaLocationView areaLocationView];
        areaView.selectCity = GFSShowCityBtn.cityName;
        [self addSubview:areaView];
        self.areaView = areaView;
        
        // 热门城市
        UILabel *hotLabel = [[UILabel alloc]init];
        hotLabel.text = @"热门城市";
        hotLabel.font = GFSCityFont;
        [self addSubview:hotLabel];
        self.hotLabel = hotLabel;
        
        // 热门城市按钮
        NSArray *array = @[@"全国",@"广州",@"北京",@"上海",@"深圳",@"武汉",@"杭州",@"成都",@"重庆"];
//        NSLog(@"%@",array[1]);
        [self setupButtonWithTitleArray:array];
        
        [self setupFrames];
    }
    
    return self;
}
- (void)setupButtonWithTitleArray:(NSArray *)array
{
    [array enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
        // 设置按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = GFSCityFont;
        btn.contentMode = UIViewContentModeCenter;
        [btn addTarget:self action:@selector(hotcityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        // 添加到数组
        [self.hotcities addObject:btn];
    }];
}
- (void)hotcityBtnClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(hotCityClicked:city:)]) {
       
        [self.delegate hotCityClicked:self city:sender.currentTitle];
    }
}
- (void)setupFrames
{
    // 定位按钮
    CGFloat areaW = [UIScreen mainScreen].bounds.size.width - 2* GFSHeaderBoarder;
    
    self.areaView.frame = CGRectMake(GFSHeaderBoarder, GFSHeaderBoarder, areaW, 40);
    
    // 热门
    CGFloat hotLabelY = CGRectGetMaxY(self.areaView.frame) + GFSHeaderBoarder;
    
    self.hotLabel.frame  = CGRectMake(GFSHeaderBoarder, hotLabelY, areaW, 40);
    // 热门城市按钮
    int totalRow = 3;
    int colums = 3;
    CGFloat btnW = ([UIScreen mainScreen].bounds.size.width - 4*GFSHeaderBoarder) / totalRow;
    CGFloat btnH = 40;
    
    for (int i = 0; i< self.hotcities.count; i++) {
        
        UIButton *btn = self.hotcities[i];
        // 计算位置  确定frame
        int col = i / totalRow;
        int row = i % colums;
        CGFloat btnX = GFSHeaderBoarder +(GFSHeaderBoarder + btnW)* col;
        CGFloat btnY = CGRectGetMaxY(self.hotLabel.frame) +GFSHeaderBoarder + (GFSHeaderBoarder +btnH)* row;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    // 总高度
    self.headerViewHeight = CGRectGetMaxY(self.hotLabel.frame) + 4*GFSHeaderBoarder + 3*btnH;

}

@end
