//
//  SuperViewController.h
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+NJ.h"

@interface SuperViewController : UIViewController

@property (nonatomic,strong)UIView *viewTitle;
@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UIButton *rightButton;
@property (nonatomic,strong)UILabel *titleLabel;

- (void)showTip:(NSString *)text;
- (void)showTip:(NSString *)text toView:(UIView *)view;

- (void)showSuccess:(NSString *)success;
- (void)showSuccess:(NSString *)success toView:(UIView *)view;

- (void)showError:(NSString *)error;
- (void)showError:(NSString *)error toView:(UIView *)view;

- (MBProgressHUD *)showMessage:(NSString *)message;
- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

- (void)hideHUD;
- (void)hideHUDForView:(UIView *)view;
@end
