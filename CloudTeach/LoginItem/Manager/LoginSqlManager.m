//
//  LoginSqlManager.m
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "LoginSqlManager.h"

static LoginSqlManager *manager = nil;

@implementation LoginSqlManager

+ (LoginSqlManager *)manager {
    if(!manager) {
        manager = [super new];
    }
    return manager;
}

- (void)selectWithParam:(NSDictionary *)param success:(RequestMySqlSuccess)success failed:(RequestMySqlFailed)failed {
    
    NSString *un = param[@"un"];
    NSString *pw = param[@"pw"];
    
    NSString *condition = [NSString stringWithFormat:@"usun = '%@' and uspw = '%@'",un,pw];
    
    [self selectFromDB:@"ct_user_info" withCondition:condition success:^(NSArray *result) {
        if(0 == result.count) {
            failed(@"登录失败");
        }else{
            success(result);
        }
    } failed:^(NSString *msg) {
        failed(msg);
    }];
}
@end
