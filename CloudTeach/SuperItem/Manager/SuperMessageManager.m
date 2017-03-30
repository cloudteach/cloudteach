//
//  SuperMessageManager.m
//  CloudTeach
//
//  Created by tiny on 17/3/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperMessageManager.h"

@implementation SuperMessageManager
//将Dictionary和Array转化为NSString
- (NSString *)dictionaryOrArrayToJsonString:(id)dictOrArray
{
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictOrArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end
