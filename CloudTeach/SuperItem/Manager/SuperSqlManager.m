//
//  SuperSqlManager.m
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperSqlManager.h"

@implementation SuperSqlManager

- (OHMySQLUser *)user {
    if(!_user) {
        _user = [[OHMySQLUser alloc] initWithUserName:@"root" password:@"" serverName:@"localhost" dbName:@"cloudteach" port:3306 socket:@"/Applications/XAMPP/xamppfiles/var/mysql/mysql.sock"];
    }
    return _user;
}

- (void)selectFromDB:(NSString *)tableName withCondition:(NSString *)condition success:(RequestMySqlSuccess)success failed:(RequestMySqlFailed)failed{
    OHMySQLStoreCoordinator *coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:self.user];
    [coordinator connect];
    
    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
    queryContext.storeCoordinator = coordinator;
    
    OHMySQLQueryRequest *query = [OHMySQLQueryRequestFactory SELECT:tableName condition:condition];
    NSError *error = nil;
    NSArray *result = [queryContext executeQueryRequestAndFetchResult:query error:&error];
    if(result) {
        success(result);
    }else{
        failed(@"error");
    }
    
}

@end
