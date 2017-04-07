//
//  RegistViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/29.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()
@property (nonatomic,strong)UITextField *tfUserName;
@property (nonatomic,strong)UITextField *tfPassWord;
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
    btnLogin.frame = CGRectMake(10, self.tfPassWord.bottom + 20, SCREEN_WIDTH-20, 40);
    btnLogin.layer.cornerRadius = 5;
    btnLogin.layer.borderColor = HEX_RGB(0x000000).CGColor;
    btnLogin.layer.borderWidth = 1;
    [btnLogin setTitleColor:HEX_RGB(0xffffff) forState:UIControlStateNormal];
    [btnLogin setTitle:@"注册" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
}

- (UITextField *)tfUserName {
    if(!_tfUserName) {
        _tfUserName = [UITextField new];
        _tfUserName.frame = CGRectMake(50, 200, SCREEN_WIDTH-100, 40);
        _tfUserName.placeholder = @"请输入用户名";
        [_tfUserName setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_tfUserName setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self.view addSubview:_tfUserName];
    }
    return _tfUserName;
}

- (UITextField *)tfPassWord {
    if(!_tfPassWord) {
        _tfPassWord = [UITextField new];
        _tfPassWord.frame = CGRectMake(50, self.tfUserName.bottom + 10, SCREEN_WIDTH-100, 40);
        _tfPassWord.placeholder = @"请输入密码";
        _tfPassWord.secureTextEntry = YES;
        [self.view addSubview:_tfPassWord];
    }
    return _tfPassWord;
}

- (void)regist {
    [self resiginKeBoard];
    [[EMClient sharedClient] registerWithUsername:_tfUserName.text password:_tfPassWord.text completion:^(NSString *aUsername, EMError *aError) {
        if(aError) {
            [self showError:[NSString stringWithFormat:@"%@",aError]];
        }else{
            [self showSuccess:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
            //保存到数据库
            AVObject *testObject = [AVObject objectWithClassName:@"cloudteach_user"];
            [testObject setObject:aUsername forKey:@"ct_username"];
            if([testObject save]) {
                NSLog(@"保存到数据库成功");
            }else{
                NSLog(@"保存到数据库失败");
            }
        }
    }];
}

- (void)resiginKeBoard {
    if(_tfUserName.firstBaselineAnchor) [_tfUserName resignFirstResponder];
    if(_tfPassWord.firstBaselineAnchor) [_tfPassWord resignFirstResponder];
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
