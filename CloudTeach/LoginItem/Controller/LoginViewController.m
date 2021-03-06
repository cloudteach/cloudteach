//
//  LoginViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManager.h"
#import "LoginSqlManager.h"
#import "RegistViewController.h"

@interface LoginViewController ()
@property (nonatomic,strong)UITextField *tfUserName;
@property (nonatomic,strong)UITextField *tfPassWord;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewTitle.hidden = YES;
    
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
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginEM) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    
    UILabel *labRegist = [UILabel new];
    labRegist.frame = CGRectMake(SCREEN_WIDTH-130, btnLogin.bottom+20, 120, 20);
    labRegist.text = @"还没有账号，去注册";
    labRegist.font = [UIFont systemFontOfSize:12];
    labRegist.userInteractionEnabled = YES;
    labRegist.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:labRegist];
    
    UIButton *btnRegist = [UIButton buttonWithType:UIButtonTypeSystem];
    btnRegist.frame = CGRectMake(0, 0, labRegist.width, labRegist.height);
    [btnRegist addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [labRegist addSubview:btnRegist];
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

- (void)login {
    NSDictionary *param = @{@"un":@"pd",@"pw":@"pd"};
    [[LoginManager manager] requestLoginInfoWithUserInfo:param success:^(NSDictionary *result) {
        LoginModel *model = result[@"model"];
        if([model.city isEqualToString:@"西安"]) {
            [self showTip:@"登录成功"];
        }else{
            [self showTip:@"登录失败"];
        }
    } failed:^(NSError *error) {
        
    }];
}

- (void)regist {
    [self resiginKeBoard];
    RegistViewController *registVC = [RegistViewController new];
    [self.navigationController pushViewController:registVC animated:YES];
}

- (void)resiginKeBoard {
    if(_tfUserName.firstBaselineAnchor) [_tfUserName resignFirstResponder];
    if(_tfPassWord.firstBaselineAnchor) [_tfPassWord resignFirstResponder];
}

- (void)testMysql {
    NSString *un = _tfUserName.text;
    NSString *pw = _tfPassWord.text;
    
    un = @"fish";
    pw = @"fish";
    
    NSDictionary *param = @{@"un":un,@"pw":pw};
    
    [[LoginSqlManager manager] selectWithParam:param success:^(NSArray *result) {
//        [self showSuccess:@"登录成功"];
        if(_block) {
            _block(YES);
        }
    } failed:^(NSString *msg) {
        [self showError:msg];
    }];
}

- (void)loginEM {
    [self resiginKeBoard];
    [self showMessage:@"正在登录"];
    [[EMClient sharedClient] loginWithUsername:_tfUserName.text password:_tfPassWord.text completion:^(NSString *aUsername, EMError *aError) {
        [self hideHUD];
        if(aError) {
            [self showError:[NSString stringWithFormat:@"%@",aError]];
        }else{
            [[EMClient sharedClient].options setIsAutoLogin:YES]; //自动登录
            if(_block) {
                _block(YES);
            }
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
