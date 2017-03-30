//
//  TextCell.m
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell

- (void)setCellContent:(id)Body withIndexPath:(NSIndexPath *)indexPath {
    [super setCellContent:Body withIndexPath:indexPath];
}

- (UILabel *)labContent {
    if(!_labContent) {
        _labContent = [UILabel new];
        _labContent.frame = CGRectZero;
        _labContent.font = [UIFont systemFontOfSize:12];
        _labContent.numberOfLines = 0;
        _labContent.lineBreakMode = NSLineBreakByCharWrapping;
        [self.viewBg addSubview:_labContent];
    }
    return _labContent;
}

+ (float)cellWidthFromMessage:(BaseMessage *)message withWidth:(float)width{
    EMTextMessageBody *textMessage = (EMTextMessageBody *)message.body;
    NSString *text = textMessage.text;
    float length = [self getLengthWithText:text];
    return MIN(length, width);
}

+ (float)cellHeightFromMessage:(BaseMessage *)message withWidth:(float)width {
    EMTextMessageBody *textMessage = (EMTextMessageBody *)message.body;
    NSString *text = textMessage.text;
    
    float height = [self getHeightWithText:text withWidth:width];
    return height;
}

+ (float)getHeightWithText:(NSString *)text withWidth:(float)width{
    float height = 0;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [paragraphStyle setLineSpacing:3];
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    //根据文字的长度和字号计算Size
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paragraphStyle};
    CGRect requiredSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    height = requiredSize.size.height;
    return height;
}

+ (float)getLengthWithText:(NSString *)text {
    float length = 0;
    
    UIFont* font = [UIFont systemFontOfSize:12];
    CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width,20);
    //根据文字的长度和字号计算Size
    NSDictionary *dict = @{NSFontAttributeName : font};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    length = rect.size.width+10;
    return length;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.labContent.text = ((EMTextMessageBody *)self.message.body).text;
    _labContent.frame = CGRectMake(5, 0, self.viewBg.width-10, self.viewBg.height);
}

@end
