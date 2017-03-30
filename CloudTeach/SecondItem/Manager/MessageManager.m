//
//  MessageManager.m
//  CloudTeach
//
//  Created by tiny on 17/3/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "MessageManager.h"

static MessageManager *manager = nil;
@implementation MessageManager

+ (MessageManager *)manager {
    if(!manager) {
        manager = [super new];
    }
    return manager;
}

- (NSArray *)stringContactToModel:(NSArray *)array {
    NSMutableArray *marrContact = [NSMutableArray array];
    
    for(NSString *name in array) {
        Contact *contact = [[Contact alloc] initContactWithName:name];
        [marrContact addObject:contact];
    }
    return marrContact;
}

#pragma mark delegate
/*!
 @method
 @brief 接收到一条及以上非cmd消息
 */
- (void)messagesDidReceive:(NSArray *)aMessages {
    for(EMMessage *message in aMessages) {
        NSLog(@"----->%@-%@-%@",message.from,message.to,((EMTextMessageBody *)message.body).text);
    }
}

/*!
 @method
 @brief 接收到一条及以上cmd消息
 */
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages {
    NSLog(@"");
}

@end
