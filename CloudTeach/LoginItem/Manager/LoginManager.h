//
//  LoginManager.h
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperManager.h"

@interface LoginManager : SuperManager
- (void)requestLoginInfoWithUserInfo:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed;
@end
