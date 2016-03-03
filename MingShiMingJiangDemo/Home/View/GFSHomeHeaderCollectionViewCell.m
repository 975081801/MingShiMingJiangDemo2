//
//  GFSHomeHeaderCollectionViewCell.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/2.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSHomeHeaderCollectionViewCell.h"
@interface GFSHomeHeaderCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation GFSHomeHeaderCollectionViewCell

- (void)awakeFromNib {
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;

}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}
@end
