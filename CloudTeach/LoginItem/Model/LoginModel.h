//
//  LoginModel.h
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperModel.h"

@interface LoginModel : SuperModel
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *country;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,assign)int ret;

@end
