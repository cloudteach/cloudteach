//
//  SuperSqlManager.h
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OHMySQL.h>

typedef void(^RequestMySqlSuccess)(NSArray *result);
typedef void(^RequestMySqlFailed)(NSString *msg);

@interface SuperSqlManager : NSObject

@property (nonatomic,strong)OHMySQLUser *user;

- (void)selectFromDB:(NSString *)tableName withCondition:(NSString *)condition success:(RequestMySqlSuccess)success failed:(RequestMySqlFailed)failed;
@end
