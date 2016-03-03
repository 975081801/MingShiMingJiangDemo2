//
//  GFSHomeCollectionViewCell.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/2.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSHomeCollectionViewCell.h"
@interface GFSHomeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation GFSHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        self = [[[NSBundle mainBundle]loadNibNamed:@"GFSHomeCollectionViewCell" owner:self options:nil]firstObject];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}
- (void)awakeFromNib
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}
@end
