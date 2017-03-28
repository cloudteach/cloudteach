//
//  SuperViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_RGB(0xffffff);
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (UIView *)viewTitle {
    if(!_viewTitle) {
        _viewTitle = [UIView new];
        _viewTitle.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        _viewTitle.backgroundColor = BASE_COLOR;
        _viewTitle.hidden = NO;
        [self.view addSubview:_viewTitle];
    }
    return _viewTitle;
}

- (UIButton *)leftButton {
    if(!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftButton.frame = CGRectMake(15, 27, 30, 30);
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.hidden = NO;
        [self.viewTitle addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if(!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightButton.frame = CGRectMake(SCREEN_WIDTH-30-15, 27, 30, 30);
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.hidden = NO;
        [self.viewTitle addSubview:_rightButton];
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(30+20, 27, SCREEN_WIDTH-(30+20)*2, 30);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = HEX_RGB(0xffffff);
        _titleLabel.text = @"Super View";
        [self.viewTitle addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonAction {
    
}

#pragma mark Hud

- (void)showTip:(NSString *)text {
    [MBProgressHUD showTip:text];
}

- (void)showTip:(NSString *)text toView:(UIView *)view {
    [MBProgressHUD showTip:text toView:view];
}

- (void)showSuccess:(NSString *)success {
    [MBProgressHUD showSuccess:success];
}
- (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [MBProgressHUD showSuccess:success toView:view];
}

- (void)showError:(NSString *)error {
    [MBProgressHUD showError:error];
}
- (void)showError:(NSString *)error toView:(UIView *)view {
    [MBProgressHUD showError:error toView:view];
}

- (MBProgressHUD *)showMessage:(NSString *)message {
    return [MBProgressHUD showMessage:message];
}
- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    return [MBProgressHUD showMessage:message toView:view];
}

- (void)hideHUD {
    [MBProgressHUD hideHUD];
}
- (void)hideHUDForView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
