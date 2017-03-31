//
//  ContactSqlManager.h
//  CloudTeach
//
//  Created by tiny on 17/3/31.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperSqlManager.h"

@interface ContactSqlManager : SuperSqlManager
+ (ContactSqlManager *)manager;
- (void)selectWithParam:(NSDictionary *)param success:(RequestMySqlSuccess)success failed:(RequestMySqlFailed)failed;
@end
