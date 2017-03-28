//
//  LoginSqlManager.h
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperSqlManager.h"

@interface LoginSqlManager : SuperSqlManager
+ (LoginSqlManager *)manager;
- (void)selectWithParam:(NSDictionary *)param success:(RequestMySqlSuccess)success failed:(RequestMySqlFailed)failed;
@end
