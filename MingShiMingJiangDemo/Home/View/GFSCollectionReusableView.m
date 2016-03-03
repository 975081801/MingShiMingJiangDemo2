//
//  GFSCollectionReusableView.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/2.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSCollectionReusableView.h"
#import "GFSHomeHeaderCollectionViewCell.h"

@interface GFSCollectionReusableView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,weak)UICollectionView *headerView;
@property(nonatomic,strong)NSArray *types;
@end
@implementation GFSCollectionReusableView
#pragma mark- 初始化  懒加载
- (NSArray *)images
{
    if (!_images) {
        NSMutableArray *array = [NSMutableArray array];
        if (iPhone6Plus) {
            // 加载@3x图
            for (int i = 0; i< 17; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"960_%02d",i]];
                // 由于序号不连续  判断是否有图片
                if (image) {// 有图片
                    [array addObject:image];
                }
            }
//            GFSLog(@"--%ld",array.count);
        }else{
            
            // 加载@2x图
            for (int i = 0; i< 14; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"640_%02d",i]];
                if (image) {// 有图片
                    [array addObject:image];
                }
            }
//            GFSLog(@"-----%ld",array.count);
        }
        _images = array;
    }
    return _images;
}
- (NSArray *)types
{
    if (!_types) {
        NSArray *array = @[@"室内设计",@"效果图",@"施工图",@"预算师",@"3D建模",@"机电设计",@"软装设计",@"园林设计"];
        
        _types = array;
    }
    return _types;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _headerView.frame = self.bounds;
    
}

#pragma mark- UICollectionViewDataSource 和 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //    GFSLog(@"---tupian%ld",self.imageArray.count);
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GFSHomeHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headercell" forIndexPath:indexPath];
    
    cell.image = self.images[indexPath.row];
    cell.type = self.types[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *type = self.types[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(headerView:clicked:)]) {
        // 将点击到的按钮代表的类型传给代理
        [self.delegate headerView:self clicked:type];
    }
}
#pragma mark- 私有方法
/**
 *  基础设置
 */
- (void)setUp
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的尺寸
    CGFloat itemW = [UIScreen mainScreen].bounds.size.width * 0.25;
    CGFloat itemH = itemW * 233 / 239  ;
    
    
    layout.itemSize = CGSizeMake(itemW , itemH);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    // 设置cell与CollectionView边缘的间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2 *itemH);
    UICollectionView *headerView = [[UICollectionView alloc]initWithFrame: frame collectionViewLayout:layout];
    [headerView registerNib:[UINib nibWithNibName:@"GFSHomeHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"headercell"];
    headerView.dataSource = self;
    headerView.delegate = self;
    headerView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:headerView];
    self.headerView = headerView;
    self.height = 2 *itemH +10;
}
@end
