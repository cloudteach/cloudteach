//
//  ChatViewController.h
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperViewController.h"

@interface ChatViewController : SuperViewController
@property (nonatomic,strong)Contact *currentContact;
@property (nonatomic,strong)EMConversation *currentConversation;
@end
