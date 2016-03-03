//
//  GFSAreaLocationView.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSAreaLocationView.h"
@interface GFSAreaLocationView()
/**
 *  定位好的city
 */
@property(nonatomic,weak)UILabel *cityLabel;
/**
 *  GPS定位
 */
@property(nonatomic,weak)UILabel *GPS;

@end
@implementation GFSAreaLocationView

//- (void)setSelectCity:(NSString *)selectCity
//{
//    _selectCity = selectCity;
//    
//    // 注册通知
//    [GFSShowCityBtn addObserver:self forKeyPath:@"currentTitle" options:0 context:nil];
//}
//- (void)setDelegate:(id<GFSAreaLocationViewDelegate>)delegate
//{
//    [self startGPS];
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        // 添加cityLabel
        UILabel *cityLabel = [[UILabel alloc]init];
        cityLabel.text = GFSShowCityBtn.cityName;
        cityLabel.textColor = [UIColor blackColor];
        cityLabel.font = GFSCityFont;
        [self addSubview:cityLabel];
        self.cityLabel = cityLabel;
        
        UILabel *GPSLabel = [[UILabel alloc]init];
        GPSLabel.text = @"GPS定位";
        GPSLabel.textColor = [UIColor grayColor];
        GPSLabel.font = GFSCityFont;
        [self addSubview:GPSLabel];
        self.GPS = GPSLabel;

    }
    return self;
}
+ (instancetype)areaLocationView
{
    return [[GFSAreaLocationView alloc]init];
}
/**
 *  定义点击事件反馈
 *
 *  @param point 点击位置
 *  @param event 点击事件
 *
 *  @return 处理者
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    if (CGRectContainsPoint(self.frame, point)) {
        
        [self startGPS];
    }
    return [super hitTest:point withEvent:event];
}
- (void)startGPS
{
    if ([self.delegate respondsToSelector:@selector(GPSViewStartLocating)]) {
        [self.delegate GPSViewStartLocating];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize citySize = [self.cityLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObject:GFSCityFont forKey:NSFontAttributeName]];
    CGFloat cityY = (40 - citySize.height) / 2 ;
    self.cityLabel.frame = CGRectMake(13, cityY, citySize.width, citySize.height);
    CGFloat gpsX = CGRectGetMaxX(self.cityLabel.frame) + 10;
    
    CGSize gpsSize = [self.GPS.text sizeWithAttributes:[NSDictionary dictionaryWithObject:GFSCityFont forKey:NSFontAttributeName]];
    
    self.GPS.frame = CGRectMake(gpsX, cityY, gpsSize.width, gpsSize.height);
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    self.cityLabel.text = GFSShowCityBtn.currentTitle;
//}
//- (void)dealloc
//{
//    [GFSShowCityBtn removeObserver:self forKeyPath:@"currentTitle"];
//}
@end
