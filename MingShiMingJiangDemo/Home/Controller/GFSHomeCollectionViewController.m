//
//  GFSHomeCollectionViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSHomeCollectionViewController.h"
#import "GFSCitiesViewController.h"
#import "GFSHomeCollectionViewCell.h"
#import "GFSCollectionReusableView.h"
#import "GFSLocateTool.h"
#import "GFSSearchViewController.h"
#import "GFSHandlerViewController.h"
#import "GFSDesignerViewController.h"


@interface GFSHomeCollectionViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,GFSCollectionReusableViewDelegate>
@property(nonatomic,weak)UISearchBar *centerSearcher;
/**
 *  首页位置显示的城市
 */
@property(nonatomic,copy)NSString *cityButtonTitle;
/**
 *  所有合适的图片
 */
@property(nonatomic,strong)NSArray *imageArray;
/**
 *  所有模块标题
 */
@property(nonatomic,strong)NSArray *types;
/**
 *  表头view  注意reuse  设置代理应该在复用位置设置
 */
@property(nonatomic,strong)GFSCollectionReusableView *headerView;
@end

@implementation GFSHomeCollectionViewController

static NSString * const ID = @"bottomcell";
#pragma mark- 初始化和懒加载
- (GFSCollectionReusableView *)headerView
{
    if (!_headerView) {
        
        GFSCollectionReusableView *headerView = [[GFSCollectionReusableView alloc]init];
        _headerView = headerView;
    }
    return _headerView;
}
- (NSArray *)types
{
    if (!_types) {
        NSArray *array = @[@"装修队长",@"泥水工",@"水电工",@"木工",@"油漆工",@"工程监理",@"家具安装",@"木地板安装",@"石材加工安装",@"电焊工",@"玻璃加工安装",@"壁纸窗帘",@"门窗定制安装",@"广告招牌",@"护栏铁艺",@"电器维修安装",@"疏通补漏",@"打孔钻孔",@"拆除工",@"搬运工"];
        _types = array;
    }
    return _types;
}
- (NSArray *)imageArray
{
    if (!_imageArray) {
        NSMutableArray *array = [NSMutableArray array];
        if (iPhone6Plus) {
            // 加载@3x图
            for (int i = 20; i< 57; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"960_%d",i]];
                // 由于序号不连续  判断是否有图片
                if (image) {// 有图片
                    [array addObject:image];
                }
            }
        }else{
            
            // 加载@2x图
            for (int i = 17; i< 57; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"640_%d",i]];
                if (image) {// 有图片
                    [array addObject:image];
                }
            }
        }
        _imageArray = array;
    }
    return _imageArray;
}
/**
 *  初始化
 *
 */
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的尺寸
    CGFloat itemW = [UIScreen mainScreen].bounds.size.width * 0.246;
    CGFloat itemH = itemW * 184 / 239  ;
    
    layout.itemSize = CGSizeMake(itemW , itemH);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 2;
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.headerView.height);
    //是否固定表头
//    layout.sectionHeadersPinToVisibleBounds = YES;
    // 设置cell与CollectionView边缘的间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    return [super initWithCollectionViewLayout:layout];
}
#pragma mark- lifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // 删除原有的 解决闪现出其他标题
//    self.navigationController.navigationItem.titleView = nil;
    
    CGSize btnSize = [GFSShowCityBtn.currentTitle sizeWithAttributes:[NSDictionary dictionaryWithObject:GFSCityFont forKey:NSFontAttributeName]];
//        GFSLog(@"----%f",btnSize.width);
    GFSShowCityBtn.frame = CGRectMake(0, 0, btnSize.width, 40);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏按钮
    [self setupNavBarButton];
    // 设置基础视图
    [self setupBaseView];
    // 检测当前位置
    [self checkCity];
}
#pragma mark - UISearchBarDelegate
/** 搜索框结束编辑（退出键盘） */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 如果正在dissmis，就不要执行后面代码
    if (self.isBeingDismissed) return;
    
    // 更换背景
//    searchBar.backgroundImage = [UIImage imageNamed:@""];
    // 隐藏取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    // 清空文字
    searchBar.text = nil;
    // 移除搜索结果界面
//    [self.SearchVc.view removeFromSuperview];
}

/** 搜索框开始编辑（弹出键盘） */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 更换背景
//    searchBar.backgroundImage = [UIImage imageNamed:@""];
    // 显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
}

/** 点击了取消 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
}

/** 搜索框的文字发生改变的时候调用 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 弹出搜索界面
    GFSSearchViewController *seachVc = [[GFSSearchViewController alloc]init];
    seachVc.title = @"搜索";
    [self.navigationController pushViewController:seachVc animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.centerSearcher endEditing:YES];
}
#pragma mark <UICollectionViewDataSource><UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    GFSLog(@"---tupian%ld",self.imageArray.count);
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GFSHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bottomcell" forIndexPath:indexPath];
    
    cell.image = self.imageArray[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *type = self.types[indexPath.row];
    
    GFSHandlerViewController *handVC = [[GFSHandlerViewController alloc]init];
    handVC.title = type;
    
    [self.navigationController pushViewController:handVC animated:YES];
}
/**
 *  添加headerView
 *
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
        GFSCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reuse" forIndexPath:indexPath ];
    headerView.delegate = self;
    return headerView;
}
#pragma mark- GFSCollectionReusableViewDelegate
- (void)headerView:(GFSCollectionReusableView *)headerView clicked:(NSString *)partType
{
    // 点击表头cell时  跳转设计类表格View
    GFSDesignerViewController *desigerTypeVc = [[GFSDesignerViewController alloc]init];
    
    desigerTypeVc.title = partType;
    
    [self.navigationController pushViewController:desigerTypeVc animated:YES];
}
#pragma mark- setterAndGetter
/**
*  初始化地址
*/
- (NSString *)cityButtonTitle
{
    // 取出当前保存的城市(之前使用过)
    NSString *cityName = [[NSUserDefaults standardUserDefaults]objectForKey:@"city"];
    _cityButtonTitle = cityName;
    
    if (!_cityButtonTitle) {
        // 如果没有  设置默认标题
        _cityButtonTitle = @"广州";
    }
    return _cityButtonTitle;
}

#pragma mark- pravitMethods
/**
 *  检测当前城市
 */
- (void)checkCity
{
    GFSLocateTool *location =  [GFSLocateTool sharedGFSLocateTool];
    [location startLocation];
    if (location.isUnAuthorization) {// 未授权 提示授权
        [self alertOpenLocationSwitch];
    }
    [location reverseGeocodeWithlatitude:location.latitude longitude:location.longitude success:^(NSString *address) {
        // 定位成功
        
        NSString *cityName = [address substringToIndex:address.length-1];
//        GFSLog(@"-----%@",cityName);
        if (![GFSShowCityBtn.cityName isEqualToString:cityName]) {
            [self alertToChangeCity:cityName];
        }
        
    } failure:^{
        // 失败
        [self alertOpenLocationFailure];
    }];

}
/**
 *  提醒定位失败
 */
- (void)alertOpenLocationFailure
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位失败请稍等或者手动选择相应城市" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertView addAction:cancelAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
    
}
/**
 *  提醒切换城市
 */
- (void)alertToChangeCity:(NSString *)cityName
{
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"您当前位置与实际不符是否切换到%@",cityName] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        GFSShowCityBtn.cityName = cityName;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [alertView addAction:cancelAction];
    [alertView addAction:okAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
  
}
/**
 *  提示打开定位
 */
- (void)alertOpenLocationSwitch
{
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在隐私设置中打开定位开关" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    
//    [alertView addAction:cancelAction];
    [alertView addAction:okAction];
    
    [self presentViewController:alertView animated:YES completion:nil];}

/**
 *  设置控制器view属性
 */
- (void)setupBaseView
{
    self.title = nil;
    // 垂直方向上永远有弹簧效果
    self.collectionView.alwaysBounceVertical = YES;
    
//    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GFSHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bottomcell"];
    
    [self.collectionView registerClass:[GFSCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reuse"];
}
/**
 *  设置导航栏按钮
 */
- (void)setupNavBarButton
{
    // 左边按钮(自定义)
    
    GFSShowCityBtn.cityName = self.cityButtonTitle;
    GFSShowCityBtn.titleLabel.font = GFSCityFont;
    
    [GFSShowCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [GFSShowCityBtn addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:GFSShowCityBtn];
    
    
    // 中间搜索
    UISearchBar *centerSearcher = [[UISearchBar alloc]init];
    // 图标
    centerSearcher.placeholder = @"搜索你想要的";
    centerSearcher.contentMode = UIViewContentModeLeft;
    // 位置和尺寸
    centerSearcher.frame = CGRectMake(0, 0, 60, 40);
    centerSearcher.delegate = self;
    self.navigationItem.titleView = centerSearcher;
    self.centerSearcher = centerSearcher;
    
}
/**
 *  定位地址点击事件
 *
 *  @param button 按钮
 */
- (void)leftButtonClicked:(GFSShowCityButton *)button
{
    UIViewController *cities = [[GFSCitiesViewController alloc]init];
    
    [self.navigationController pushViewController:cities animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
