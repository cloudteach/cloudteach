//
//  ImageCell.m
//  CloudTeach
//
//  Created by tiny on 17/3/29.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (void)setCellContent:(BaseMessage *)Body withIndexPath:(NSIndexPath *)indexPath {
    [super setCellContent:Body withIndexPath:indexPath];
}

- (UIImageView *)imgvContent {
    if(!_imgvContent) {
        _imgvContent = [UIImageView new];
        _imgvContent.frame = CGRectZero;
        _imgvContent.layer.borderColor = HEX_RGB(0xeceec).CGColor;
        _imgvContent.layer.borderWidth = 1;
        _imgvContent.layer.cornerRadius = 5;
        [_imgvContent.layer setMasksToBounds:YES];
        _imgvContent.contentMode = UIViewContentModeScaleAspectFit;
        [self.viewBg addSubview:_imgvContent];
    }
    return _imgvContent;
}

+ (float)cellWidthFromMessage:(BaseMessage *)message withWidth:(float)width{
    return MIN(90, width);
}

+ (float)cellHeightFromMessage:(BaseMessage *)message withWidth:(float)width {
    return 120;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSURL *url = [NSURL URLWithString:[((ImageMessage*)self.message).imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self.imgvContent.frame = CGRectMake(0, 0, 90, 120);
    [_imgvContent sd_setImageWithURL:url];
    
    self.imgvBubble.hidden = YES;
}

@end