//
//  LoginManager.m
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager

- (void)requestLoginInfoWithUserInfo:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed {
    NSString *url = @"http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json";
    [self methodGetRequestWithUrl:url withParam:param success:^(NSDictionary *result) {
        NSError *error = nil;
        LoginModel *model = [[LoginModel alloc] initWithString:result[@"json"] error:&error];
        if(model) {
            success(@{@"model":model});
        }else{
            success(nil);
        }
    } failed:^(NSError *error) {
        failed(error);
    }];
}

@end
