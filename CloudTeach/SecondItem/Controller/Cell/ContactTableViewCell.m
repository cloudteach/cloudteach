//
//  ContactTableViewCell.m
//  CloudTeach
//
//  Created by tiny on 17/3/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)setCellContent:(id)Body withIndexPath:(NSIndexPath *)indexPath {
    self.contact = Body;
}

- (UILabel *)labName {
    if(!_labName) {
        _labName = [UILabel new];
        _labName.frame = CGRectZero;
        _labName.textColor = HEX_RGB(0x000000);
        [self.contentView addSubview:_labName];
    }
    return _labName;
}

- (void)layoutSubviews {
    self.labName.text = self.contact.name;
    self.labName.frame = CGRectMake(60, 0, SCREEN_WIDTH-60, 60);
}

@end
