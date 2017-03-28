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
    self.header.hidden = NO;
    self.content.hidden = NO;
    self.detail.hidden = NO;
    self.time.hidden = NO;
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

- (UILabel *)content {
    if(!_content) {
        _content = [UILabel new];
        _content.frame = CGRectMake(55, 0, SCREEN_WIDTH - (40+10)*2, 30);
        _content.textColor = HEX_RGB(0x000000);
        _content.text = @"潘东";
        _time.font = [UIFont systemFontOfSize:13];
        _content.textVerticalAlignment = UITextVerticalAlignmentMiddle;
        [self.contentView addSubview:_content];
    }
    return _content;
}

- (UILabel *)detail {
    if(!_detail) {
        _detail = [UILabel new];
        _detail.frame = CGRectMake(55, 30, SCREEN_WIDTH - 55, 30);
        _detail.textColor = HEX_RGB(0xb1b1b1);
        _detail.text = @"带领我们走向胜利";
        _time.font = [UIFont systemFontOfSize:12];
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
        _time.text = @"2017/12/12 10:10";
        _time.font = [UIFont systemFontOfSize:12];
        _time.textVerticalAlignment = UITextVerticalAlignmentMiddle;
        _time.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_time];
    }
    return _detail;
}

@end
