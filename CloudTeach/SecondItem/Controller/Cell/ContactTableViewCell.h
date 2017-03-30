//
//  ContactTableViewCell.h
//  CloudTeach
//
//  Created by tiny on 17/3/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperTableViewCell.h"

@interface ContactTableViewCell : SuperTableViewCell
@property (nonatomic,strong)UILabel *labName;
@property (nonatomic,strong)Contact *contact;
@end
