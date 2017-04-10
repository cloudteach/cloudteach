//
//  QNTokenManager.h
//  CloudTeach
//
//  Created by tiny on 17/4/7.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNTokenManager : NSObject

+ (NSString *)token;

#pragma mark - 私有空间
+ (NSString *)privateRealDownloadUrlWithUrl:(NSString *)url;
@end
