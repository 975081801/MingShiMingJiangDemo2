//
//  GFSHttpTool.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/3/3.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSHttpTool.h"

#import "AFNetworking.h"

@implementation GFSHttpTool
+ (void)POSTWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2. 发送请求
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        // 参数为比传
        
        NSLog(@"-------%lld", uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
// 收到通知调用的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(NSProgress *)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%f",1.0 * object.completedUnitCount / object.totalUnitCount);
    // 回到主队列刷新UI
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //
    //    });
}
+ (void)POSTWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success :(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2. 发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        
        for (GFSFormData *formData in formDataArray) {
            
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 给Progress添加监听 KVO
        //        [uploadProgress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}
+ (void)GETWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2. 发送请求
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}
@end

@implementation GFSFormData



@end

