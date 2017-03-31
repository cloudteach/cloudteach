//
//  Contact.h
//  CloudTeach
//
//  Created by tiny on 17/3/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperModel.h"

@interface Contact : SuperModel
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *head;
- (Contact *)initContactWithName:(NSString *)name;
@end
