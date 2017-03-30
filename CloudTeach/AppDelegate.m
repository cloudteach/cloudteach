//
//  AppDelegate.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "AppDelegate.h"
#import "CTTabBarViewController.h"
#import "LoginViewController.h"

static NSString *appdkey_forEM = @"1194170328115410#cloudteach";
static NSString *push_dev = @"cloudteach_push_development";
NSString *push_dis = @"cloudteach_push_distribution";

@interface AppDelegate ()
<EMClientDelegate,EMChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册通知
    [self addNotifications];
    
//注册环信-----------------------------------------------------------------------------------
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:appdkey_forEM];
    options.apnsCertName = push_dev;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //添加回调监听代理:
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].chatManager addDelegate:[MessageManager manager] delegateQueue:nil];
//注册环信-----------------------------------------------------------------------------------
    
    __block UINavigationController *rootNav = nil;
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    
    if(isAutoLogin) {
        CTTabBarViewController *ctTabBarVC = [CTTabBarViewController new];
        rootNav = [[UINavigationController alloc] initWithRootViewController:ctTabBarVC];
    }else{
        LoginViewController *loginVC = [LoginViewController new];
        loginVC.block = ^(BOOL finish) {
            if(finish) {
                CTTabBarViewController *ctTabBarVC = [CTTabBarViewController new];
                rootNav = [[UINavigationController alloc] initWithRootViewController:ctTabBarVC];
                self.window.rootViewController = rootNav;
            }
        };
        rootNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    }
    
    self.window.rootViewController = rootNav;
    
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//统一注册通知
- (void)addNotifications{
    //退出登录
    [[NSNotificationCenter defaultCenter] removeObserver:@"initRootViewController"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initRootViewController) name:@"initRootViewController" object:nil];
    
    //移除消息回调
//    [[EMClient sharedClient].chatManager removeDelegate:self];
    //注册消息回调
//    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

//重新设置RootViewController
- (void)initRootViewController {
    self.window.rootViewController = nil;
    
    LoginViewController *loginVC = [LoginViewController new];
    __block UINavigationController *rootNav = nil;
    loginVC.block = ^(BOOL finish) {
        if(finish) {
            CTTabBarViewController *ctTabBarVC = [CTTabBarViewController new];
            rootNav = [[UINavigationController alloc] initWithRootViewController:ctTabBarVC];
            self.window.rootViewController = rootNav;
        }
    };
    rootNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = rootNav;
}

#pragma mark EMdelegate
/*!
 *  自动登录返回结果
 *
 *  @param error 错误信息
 */
- (void)autoLoginDidCompleteWithError:(EMError *)error{
    if(error) {
        NSLog(@"%@",error);
    }
}

/*!
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况，会引起该方法的调用：
 *  1. 登录成功后，手机无法上网时，会调用该回调
 *  2. 登录成功后，网络状态变化时，会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState {
    NSLog(@"");
}

/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)userAccountDidLoginFromOtherDevice {
    
}

/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)userAccountDidRemoveFromServer {
    
}

@end
