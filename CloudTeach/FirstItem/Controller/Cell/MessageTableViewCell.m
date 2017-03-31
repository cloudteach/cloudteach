//
//  MessageTableViewCell.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)setCellContent:(id)Body withIndexPath:(NSIndexPath *)indexPath {
    self.conversation = Body;
    [self getContact];
}

- (UIImageView *)header {
    if(!_header) {
        _header = [UIImageView new];
        _header.frame = CGRectMake(10, 10, 40, 40);
        _header.backgroundColor = HEX_RGB(0x999999);
        _header.layer.cornerRadius = 20;
        [_header.layer setMasksToBounds:YES];
        [self.contentView addSubview:_header];
    }
    return _header;
}

- (UILabel *)title {
    if(!_title) {
        _title = [UILabel new];
        _title.frame = CGRectMake(55, 0, SCREEN_WIDTH - (40+10)*2, 30);
        _title.textColor = HEX_RGB(0x000000);
        _title.font = [UIFont systemFontOfSize:13];
        _title.textVerticalAlignment = UITextVerticalAlignmentMiddle;
        [self.contentView addSubview:_title];
    }
    return _title;
}

- (UILabel *)detail {
    if(!_detail) {
        _detail = [UILabel new];
        _detail.frame = CGRectMake(55, 30, SCREEN_WIDTH - 55, 30);
        _detail.textColor = HEX_RGB(0xb1b1b1);
        _detail.font = [UIFont systemFontOfSize:12];
        _detail.textVerticalAlignment = UITextVerticalAlignmentMiddle;
        [self.contentView addSubview:_detail];
    }
    return _detail;
}

- (UILabel *)time {
    if(!_time) {
        _time = [UILabel new];
        _time.frame = CGRectMake(0, 0, SCREEN_WIDTH - 15, 30);
        _time.textColor = HEX_RGB(0xb1b1b1);
        _time.font = [UIFont systemFontOfSize:12];
        _time.textVerticalAlignment = UITextVerticalAlignmentMiddle;
        _time.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_time];
    }
    return _time;
}

- (void)layoutSubviews {

    [self getHead];
    self.title.text = self.conversation.conversationId;
    self.detail.text = [self getDetailText];
    self.time.text = [self getTimeText];
}

- (void)getContact {
    NSDictionary *param = @{@"un":self.conversation.conversationId};
    
    [[ContactSqlManager manager] selectWithParam:param success:^(NSArray *result) {
        
        id object = result.firstObject;
        self.contact = [[Contact alloc] initWithString:[Common dictionaryOrArrayToJsonString:object] error:nil];
    } failed:^(NSString *msg) {
        NSLog(@"");
    }];
}

- (void)getHead {
    
    if(self.contact.head.length) {
       [self.header sd_setImageWithURL:[NSURL URLWithString:self.contact.head] placeholderImage:[UIImage imageNamed:@"head"]];
    }else{
        
    }
}

- (NSString *)getDetailText {
    NSString *detail = @"未知类型";
    EMMessageBody *body = self.conversation.latestMessage.body;
    switch (self.conversation.latestMessage.body.type) {
        case EMMessageBodyTypeText:
        {
            EMTextMessageBody *textBody = (EMTextMessageBody *)body;
            detail = textBody.text;
        }
            break;
        case EMMessageBodyTypeImage:
        {
            detail = @"[图片]";
        }
            break;
        default:
            break;
    }

    return detail;
}

- (NSString *)getTimeText {
    NSString *time = @"";
    
    EMMessage *message = self.conversation.latestMessage;
    
    NSDate *messageDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
    time = [NSString stringWithFormat:@"%@",[messageDate minuteDescription]];
    return time;
}

@end
