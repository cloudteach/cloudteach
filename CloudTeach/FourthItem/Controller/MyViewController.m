//
//  MyViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLogin.frame = CGRectMake(10, SCREEN_HEIGHT-64-60, SCREEN_WIDTH-20, 40);
    btnLogin.layer.cornerRadius = 5;
    btnLogin.layer.borderColor = HEX_RGB(0x000000).CGColor;
    btnLogin.layer.borderWidth = 1;
    [btnLogin setTitleColor:HEX_RGB(0x000000) forState:UIControlStateNormal];
    [btnLogin setTitle:@"退出登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
}

- (void)logout {
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        if(aError) {
            [self showError:[NSString stringWithFormat:@"%@",aError]];
        }else{
            [self initRootViewController];
            [self showSuccess:@"退出登录成功"];
        }
    }];
}

- (void)initRootViewController {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"initRootViewController" object:nil];
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
