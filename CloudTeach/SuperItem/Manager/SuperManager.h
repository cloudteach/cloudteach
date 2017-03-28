//
//  SuperManager.h
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define REQUEST_GET         @"get"
#define REQUEST_POST        @"post"

typedef void(^RequestSuccessBlock)(NSDictionary *result);
typedef void(^RequestFailedBlock)(NSError *error);

@interface SuperManager : AFHTTPSessionManager

- (void)methodGetRequestWithUrl:(NSString *)url withParam:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed;

- (void)methodPostRequestWithUrl:(NSString *)url withParam:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed;
@end
