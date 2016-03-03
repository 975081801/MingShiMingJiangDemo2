//
//  GFSCitiesViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSCitiesViewController.h"
#import "GFSCity.h"
#import "GFSCityViewHeaderView.h"
#import "GFSAreaLocationView.h"
#import "GFSLocateTool.h"
@interface GFSCitiesViewController()<GFSAreaLocationViewDelegate,GFSCityViewHeaderViewDelegate>
/**
 *  所有城市
 */
@property(nonatomic,strong)NSMutableArray *cities;
/**
 *  所有城市拼音分组
 */
@property(nonatomic,strong)NSArray *cityPinyinSort;
/**
 *  所有城市与首字母的键值对
 */
@property(nonatomic,strong)NSMutableDictionary *cityDicts;
/**
 *  表格头部
 */
@property(nonatomic,weak)GFSCityViewHeaderView *headerView;

@end
@implementation GFSCitiesViewController

#pragma mark- lifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.sectionIndexColor = [UIColor whiteColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor grayColor];
    [self setupHeaderView];
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
}
#pragma mark TableViewDataSource and Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityPinyinSort.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.cityDicts objectForKey:_cityPinyinSort[section]]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    static NSString *GroupedTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             GroupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:GroupedTableIdentifier];
    }
    
    NSMutableArray *array=[_cityDicts objectForKey:[_cityPinyinSort objectAtIndex:section]];
    
    //给Label附上城市名称  key 为：C_Name
    cell.textLabel.text = [array objectAtIndex:row];
    cell.textLabel.font = GFSCityFont;
    
    return cell;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 组标题
//    NSString *header = _cityPinyinSort[section];
//    return header.uppercaseString;
    return _cityPinyinSort[section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //返回省份的数组
    
    return _cityPinyinSort;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSMutableArray *array=[_cityDicts objectForKey:[_cityPinyinSort objectAtIndex:section]];
    
//    [GFSShowCityBtn setTitle:[array objectAtIndex:row] forState:UIControlStateNormal];
    GFSShowCityBtn.cityName = [array objectAtIndex:row];  
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark- pravitMathods
/**
 *  设置表格头
 */
- (void)setupHeaderView
{
    self.title = @"选择城市";
    GFSCityViewHeaderView *header = [GFSCityViewHeaderView header];
    
    header.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, header.headerViewHeight);
    header.delegate = self;
    header.areaView.delegate = self;
    self.headerView = header;
    self.tableView.tableHeaderView = self.headerView;
//    GFSLog(@"%@",self.headerView.frame.size.width);
    
}
/**
 *  提示打开定位
 */
- (void)alertOpenLocationSwitch
{
   
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在隐私设置中打开定位开关" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alertView addAction:cancelAction];
    [alertView addAction:okAction];
    
    [self presentViewController:alertView animated:YES completion:nil];}
/**
 *  定位失败
 */
- (void)alertOpenLocationFailure
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位失败请稍等或者重试" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        // 重新定位
//        [self GPSViewStartLocating];
//    }];
//    [alertView addAction:cancelAction];
//    [alertView addAction:okAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView dismissViewControllerAnimated:YES completion:nil];
    });
}
#pragma mark- 自定义控件的代理方法
- (void)GPSViewStartLocating
{
    GFSLog(@"-----开始定位");
    GFSLocateTool *location =  [GFSLocateTool sharedGFSLocateTool];
    [location startLocation];
    if (location.isUnAuthorization) {// 未授权 提示授权
        [self alertOpenLocationSwitch];
    }
    [location reverseGeocodeWithlatitude:location.latitude longitude:location.longitude success:^(NSString *address) {
        // 定位成功
        GFSLog(@"%@",address);
        NSString *cityName = [address substringToIndex:address.length-1];
//        [GFSShowCityBtn setTitle:cityName forState:UIControlStateNormal];
        GFSShowCityBtn.cityName = cityName;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^{
        // 失败
        [self alertOpenLocationFailure];
    }];
}

- (void)hotCityClicked:(GFSCityViewHeaderView *)headerView city:(NSString *)cityName
{
    GFSShowCityBtn.cityName = cityName;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark- setter and getter
- (NSMutableArray *)cities
{
    if (!_cities) {
        // 从plist加载
        NSArray *cityStrArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citiesArray" ofType:@"plist"]];
        
        NSMutableArray *cityArray = [NSMutableArray array];
        for (NSString *cityStr in cityStrArray) {
            
            GFSCity *city = [GFSCity city];
            city.name = cityStr;
            
            [cityArray addObject:city];
        }
        _cities = cityArray;
    }
    return _cities;
}
- (NSArray *)cityPinyinSort
{
    if (!_cityPinyinSort) {
        // 用来储存对应分组的字典
        NSMutableDictionary *cityDic=[[NSMutableDictionary alloc]init];
        NSMutableArray *arr = nil;
        NSString *pinyin = nil;
        for (GFSCity *city in self.cities) {
            
            pinyin = [city.pinyin substringToIndex:1];;
            //如果包含key
            if([[cityDic allKeys]containsObject:pinyin]){
                // 取出对应数组
                arr=[cityDic objectForKey:pinyin];
                // 添加符合的city
                [arr addObject:city.name];
                // 更新
                [cityDic setObject:arr forKey:pinyin];
                
            }else{
                
                arr= [[NSMutableArray alloc]initWithObjects:city.name, nil];
                [cityDic setObject:arr forKey:pinyin];
                
            }
        }
        // 赋值
        self.cityDicts = cityDic;
        // 根据字母取出分组
        NSMutableArray *array = [NSMutableArray array];
        _cityPinyinSort = [array arrayByAddingObjectsFromArray:[[cityDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];;
    }
    return _cityPinyinSort;
}
@end
