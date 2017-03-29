//
//  BaseChatCell.h
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperTableViewCell.h"

@interface BaseChatCell : SuperTableViewCell
@property (nonatomic,strong) UIImageView *imgvHead;
@property (nonatomic,strong) UIView *viewBg;
@property (nonatomic,strong) UIImageView *imgvBubble;

@property (nonatomic,strong)BaseMessage *message;

+ (float)cellHeightFromMessage:(BaseMessage *)message;

@end
