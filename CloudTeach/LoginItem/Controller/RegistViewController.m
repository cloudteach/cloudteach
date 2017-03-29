//
//  RegistViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/29.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewTitle.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"";
    self.leftButton.hidden = NO;
    
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    UIImageView *imgvBg = [UIImageView new];
    imgvBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    imgvBg.image = [UIImage imageNamed:@"bg"];
    [self.view insertSubview:imgvBg atIndex:0];
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLogin.frame = CGRectMake(10, 120, SCREEN_WIDTH-20, 40);
    btnLogin.layer.cornerRadius = 5;
    btnLogin.layer.borderColor = HEX_RGB(0x000000).CGColor;
    btnLogin.layer.borderWidth = 1;
    [btnLogin setTitleColor:HEX_RGB(0xffffff) forState:UIControlStateNormal];
    [btnLogin setTitle:@"注册" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
}

- (void)regist {
    [[EMClient sharedClient] registerWithUsername:@"fish" password:@"fish" completion:^(NSString *aUsername, EMError *aError) {
        if(aError) {
            [self showError:[NSString stringWithFormat:@"%@",aError]];
        }else{
            [self showSuccess:@"注册成功"];
        }
    }];
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
