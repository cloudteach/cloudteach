//
//  BaseMessage.h
//  CloudTeach
//
//  Created by tiny on 17/3/29.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperModel.h"

typedef enum{
    message_text  = 1,
    message_image = 2
    
}Message_Type;

typedef enum{
    message_direct_self = 1,
    message_direct_other = 2
}Message_Direct;

@interface BaseMessage : SuperModel
@property (nonatomic,assign)int type;
@property (nonatomic,copy)NSString *sender;
@property (nonatomic,assign)Message_Direct msgDirect;
@end
