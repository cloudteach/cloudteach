//
//  MyViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()
@property (nonatomic,strong)UIImageView *imgvHead;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    self.imgvHead.hidden = NO;
    
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

- (UIImageView *)imgvHead {
    if(!_imgvHead) {
        _imgvHead = [UIImageView new];
        _imgvHead.frame = CGRectMake((SCREEN_WIDTH-60)/2, 74, 60, 60);
        _imgvHead.userInteractionEnabled = YES;
        _imgvHead.backgroundColor = [UIColor lightGrayColor];
        _imgvHead.layer.cornerRadius = _imgvHead.width/2;
        _imgvHead.layer.masksToBounds = YES;
        [self.view addSubview:_imgvHead];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, _imgvHead.width, _imgvHead.height);
        [button addTarget:self action:@selector(changeHead) forControlEvents:UIControlEventTouchUpInside];
        [_imgvHead addSubview:button];
    }
    return _imgvHead;
}

- (void)changeHead {
    NSLog(@"---");
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
