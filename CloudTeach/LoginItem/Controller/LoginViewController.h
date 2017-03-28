//
//  LoginViewController.h
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperViewController.h"

typedef void(^LoginSuccessBlock)(BOOL finish);

@interface LoginViewController : SuperViewController
@property (nonatomic,strong)LoginSuccessBlock block;
@end
