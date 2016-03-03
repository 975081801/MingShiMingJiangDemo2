//
//  UIViewController+GFS.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "UIViewController+GFS.h"
@implementation UIViewController (GFS)
- (void)showsAlertViewWithTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    
//    [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
//        hud.progress = progress;
//    } completionCallback:^{
//        [hud hide:YES];
//    }];
}
- (void)showAlertViewIndeterWith:(SEL)action
{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        
        [self performSelector:action];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        });
    });

}
#warning 待完善的分类
//- (void)doSomeWorkWithProgress {
////    self.canceled = NO;
//    // This just increases the progress indicator in a loop.
//    float progress = 0.0f;
//    while (progress < 1.0f) {
//        if (self.canceled) break;
//        progress += 0.01f;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // Instead we could have also passed a reference to the HUD
//            // to the HUD to myProgressTask as a method parameter.
//            [MBProgressHUD HUDForView:self.navigationController.view].progress = progress;
//        });
//        usleep(50000);
//    }
//}
@end
