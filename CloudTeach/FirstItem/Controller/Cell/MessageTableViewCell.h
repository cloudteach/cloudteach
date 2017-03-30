//
//  MessageTableViewCell.h
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperTableViewCell.h"

@interface MessageTableViewCell : SuperTableViewCell

@property (nonatomic,strong)EMConversation *conversation;
@property (nonatomic,strong)UIImageView *header;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *detail;
@property (nonatomic,strong)UILabel *time;
@end
