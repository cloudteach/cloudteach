//
//  SuperScrollViewController.h
//  CloudTeach
//
//  Created by tiny on 17/4/5.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperScrollViewController : SuperViewController
@property (nonatomic,strong)UIScrollView *superScrollView;
@property (nonatomic,assign)BOOL isHeaderShow;
@property (nonatomic,assign)BOOL isCanScroll;
@end
