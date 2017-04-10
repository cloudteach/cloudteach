//
//  QNTokenManager.m
//  CloudTeach
//
//  Created by tiny on 17/4/7.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "QNTokenManager.h"
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "QNUrlSafeBase64.h"
#import "QN_GTM_Base64.h"

#define AccessKey @"nj55lsYTFL313VhSSH4F2TX2p_OvpH7f2yu0adZ8"
#define SecretKey @"2_ukQe8Yeiunz7GCWD7qdZIK3UTIMUnSuQjG3GuP"

#define cloudteach @"cloudteach"

@implementation QNTokenManager

+ (NSString*)dictionryToJSONString:(NSMutableDictionary *)dictionary
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)token {
    
    return [self makeToken:AccessKey secretKey:SecretKey baseName:[self marshal:cloudteach]];
}


+ (NSString *) hmacSha1Key:(NSString*)key textData:(NSString*)text
{
    const char *cData  = [text cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    
    NSString *hash = [QNUrlSafeBase64 encodeData:HMAC];
    
    
    return hash;
}

+ (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey baseName:(NSString *)baseName
{
    
    //名字
    baseName = [baseName stringByReplacingOccurrencesOfString:@" " withString:@""];
    baseName = [baseName stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData   *baseNameData = [baseName dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseNameBase64 = [QNUrlSafeBase64 encodeData:baseNameData];
    
    NSString *secretKeyBase64 =  [self hmacSha1Key:secretKey textData:baseNameBase64];
    
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",  accessKey, secretKeyBase64, baseNameBase64];
    
    return token;
}

+ (NSString *)marshal:(NSString *)Scope
{
    time_t deadline;
    time(&deadline);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:Scope forKey:@"scope"];
    
    NSInteger currTime = [NSDate date].timeIntervalSince1970 + 60 *5;
    NSNumber *escapeNumber = [NSNumber numberWithInteger:currTime];
    [dic setObject:escapeNumber forKey:@"deadline"];
    
    NSString *json = [self dictionryToJSONString:dic];
    
    return json;
}



#pragma mark - 私有空间
//图片url：http://odhe8bcfz.bkt.clouddn.com/2016-09-14_15:09:56_rNTDJxV6.jpg
+ (NSString *)privateRealDownloadUrlWithUrl:(NSString *)url{
    
    //当前时间5分钟
    NSInteger currTime = [NSDate date].timeIntervalSince1970 + 60 *5;
    //添加时间戳e=1473839984
    NSString *timeUrl = [NSString stringWithFormat:@"%@?e=%@",url,@(currTime)];
    //先sha1编码  在base64编码
    NSString *token = [self hmacSha1Key:SecretKey textData:timeUrl];
    //拼接Url
    NSString *newUrl = [NSString stringWithFormat:@"%@&token=%@:%@",  timeUrl, AccessKey, token];
    
    return newUrl;
}

@end
