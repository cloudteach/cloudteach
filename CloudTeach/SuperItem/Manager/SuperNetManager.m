//
//  SuperNetManager.m
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperNetManager.h"

static SuperNetManager *manager = nil;

@implementation SuperNetManager

+ (SuperNetManager *)manager {
    if(!manager) {
        manager = [super manager];
    }
    return manager;
}

- (void)methodGetRequestWithUrl:(NSString *)url withParam:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed {
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *json = [Common dictionaryOrArrayToJsonString:responseObject];
        success(@{@"json":json});
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

- (void)methodPostRequestWithUrl:(NSString *)url withParam:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed {
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(@{@"result":responseObject});
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

@end
