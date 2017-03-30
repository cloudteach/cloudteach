//
//  HPPSuperViewController.m
//  HNABim
//
//  Created by tiny on 17/3/6.
//  Copyright © 2017年 刘欢. All rights reserved.
//

#import "HPPSuperViewController.h"

@interface HPPSuperViewController ()
@end

@implementation HPPSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_RGB(0xffffff);
    // Do any additional setup after loading the view.
    
    [self initTitleView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)initTitleView {
    
    [self.view addSubview:self.viewTitle];
    [self.view bringSubviewToFront:_viewTitle];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.frame = CGRectMake(5, 20, 44, 44);
//    [btnLeft setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_viewTitle addSubview:btnLeft];
    
    _titleLabel.hidden = NO;
}

- (UIView *)viewTitle {
    if(!_viewTitle) {
        _viewTitle = [UIView new];
        _viewTitle.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        _viewTitle.backgroundColor = BASE_COLOR;
    }
    
    return _viewTitle;
}

- (UIButton *)rightButton {
    if(!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightButton.frame = CGRectMake(SCREEN_WIDTH - 44 - 5, 20, 44, 44);
        [_rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_viewTitle addSubview:_rightButton];
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(5 + 44, 27, SCREEN_WIDTH-5*2-44*2, 30);
        _titleLabel.textColor = HEX_RGB(0xffffff);
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_viewTitle addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)backClick {
    if(1 == self.navigationController.viewControllers.count) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
