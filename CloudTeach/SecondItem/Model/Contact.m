//
//  Contact.m
//  CloudTeach
//
//  Created by tiny on 17/3/30.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "Contact.h"

@implementation Contact
- (Contact *)initContactWithName:(NSString *)name {
    Contact *contact = [Contact new];
    contact.name = name;
    return contact;
}
@end
