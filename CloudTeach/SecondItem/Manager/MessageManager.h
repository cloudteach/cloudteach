//
//  MessageManager.h
//  CloudTeach
//
//  Created by tiny on 17/3/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperMessageManager.h"

@interface MessageManager : SuperMessageManager<EMChatManagerDelegate>
+ (MessageManager *)manager;
- (NSArray *)stringContactToModel:(NSArray *)array;
@end
