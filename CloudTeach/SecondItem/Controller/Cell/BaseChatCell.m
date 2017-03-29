//
//  BaseChatCell.m
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "BaseChatCell.h"

float border_distance = 100;

@implementation BaseChatCell

- (void)setCellContent:(BaseMessage *)Body withIndexPath:(NSIndexPath *)indexPath {
    self.message = Body;
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    return self;
//}

+ (float)cellHeightFromMessage:(BaseMessage *)message {
    float maxWidth = SCREEN_WIDTH - border_distance;
    float bgHeight = [self cellHeightFromMessage:message withWidth:maxWidth];
    return MAX(bgHeight+20+2, 50);
}

+ (float)cellWidthFromMessage:(BaseMessage *)message withWidth:(float)width{
    NSLog(@"");
    return 0;
}

+ (float)cellHeightFromMessage:(BaseMessage *)message withWidth:(float)width {
    NSLog(@"");
    return 0;
}

- (UIImageView *)imgvHead {
    if(!_imgvHead) {
        _imgvHead = [UIImageView new];
        _imgvHead.frame = CGRectZero;
        _imgvHead.backgroundColor = HEX_RGB(0xececec);
        _imgvHead.image = [UIImage imageNamed:@"head"];
        _imgvHead.layer.cornerRadius = _imgvHead.width/2;
        [_imgvHead.layer setMasksToBounds:YES];
        [self.contentView addSubview:_imgvHead];
    }
    return _imgvHead;
}

- (UIView *)viewBg {
    if(!_viewBg) {
        _viewBg = [UIView new];
        _viewBg.frame = CGRectZero;
        [self.contentView addSubview:_viewBg];
    }
    return _viewBg;
}

- (UIImageView *)imgvBubble {
    if(!_imgvBubble) {
        _imgvBubble = [UIImageView new];
        _imgvBubble.frame = CGRectZero;
        [self.viewBg addSubview:_imgvBubble];
    }
    return _imgvBubble;
}

- (void)layoutSubviews {
    float height;
    float width;
    
    float maxWidth = SCREEN_WIDTH - border_distance;
    width = [[self class] cellWidthFromMessage:self.message withWidth:maxWidth];
    height = [[self class] cellHeightFromMessage:self.message];
    
    if(message_direct_self == self.message.msgDirect) {
        self.imgvHead.frame = CGRectMake(SCREEN_WIDTH-40, (height-30)/2, 30, 30);
        self.viewBg.frame = CGRectMake(SCREEN_WIDTH-width-50, 10, width, height-20);
        self.imgvBubble.frame = CGRectMake(0, 0, _viewBg.width+5, _viewBg.height);
        _imgvBubble.image = [[UIImage imageNamed:@"br"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    }else if(message_direct_other == self.message.msgDirect) {
        self.imgvHead.frame = CGRectMake(10, (height-30)/2, 30, 30);
        self.viewBg.frame = CGRectMake(50, 10, width, height-20);
        self.imgvBubble.frame = CGRectMake(-5, 0, _viewBg.width+5, _viewBg.height);
        _imgvBubble.image = [[UIImage imageNamed:@"bl"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    }
}

@end
