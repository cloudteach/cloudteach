//
//  CTTabBarViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "CTTabBarViewController.h"
#import "MessageViewController.h"
#import "ContactViewController.h"
#import "ApplicationViewController.h"
#import "MyViewController.h"

@interface CTTabBarViewController ()

@end

@implementation CTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MessageViewController *messageVC = [MessageViewController new];
    messageVC.tabBarItem.title = @"消息";
    messageVC.tabBarItem.image = [[UIImage imageNamed:@"message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"message_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ContactViewController *contactVC = [ContactViewController new];
    contactVC.tabBarItem.title = @"联系人";
    contactVC.tabBarItem.image = [[UIImage imageNamed:@"contact"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contactVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"contact_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ApplicationViewController *applicationVC = [ApplicationViewController new];
    applicationVC.tabBarItem.title = @"应用";
    applicationVC.tabBarItem.image = [[UIImage imageNamed:@"application"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    applicationVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"application_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MyViewController *myVC = [MyViewController new];
    myVC.tabBarItem.title = @"我的";
    myVC.tabBarItem.image = [[UIImage imageNamed:@"my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"my_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[messageVC,contactVC,applicationVC,myVC];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
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
