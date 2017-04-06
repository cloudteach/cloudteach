//
//  ApplicationViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "ApplicationViewController.h"
#import "TestAViewController.h"
#import "TestBViewController.h"
#import "SuperScrollViewController.h"

static float headerHeight = 60;
static float bannerHeight = 30;

@interface ApplicationViewController ()<UIScrollViewDelegate>
{
    UIScrollView *ascrollView;
    UIView *body;
    BOOL isHeaderHidden;
}
@end

@implementation ApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ascrollView = [UIScrollView new];
//    ascrollView.frame = CGRectMake(0, 64, SCREEN_WIDTH, BODY_HEIGHT);
//    ascrollView.tag = 99;
//    ascrollView.contentSize = CGSizeMake(SCREEN_WIDTH, BODY_HEIGHT + headerHeight);
//    ascrollView.delegate = self;
//    ascrollView.backgroundColor = [UIColor lightGrayColor];
//    ascrollView.bounces = NO;
//    [self.view addSubview:ascrollView];
//    
//    TestAViewController *a = [TestAViewController new];
//    TestBViewController *b = [TestBViewController new];
//    
//    NSArray *arrChild = @[a,b];
//    
//    
//    UIView *header = [UIView new];
//    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, headerHeight);
//    header.backgroundColor = [UIColor redColor];
//    [ascrollView addSubview:header];
//    
//    body = [UIView new];
//    body.frame = CGRectMake(0, header.bottom, SCREEN_WIDTH, BODY_HEIGHT-header.height);
//    [ascrollView addSubview:body];
//    
//    UIView *banner = [UIView new];
//    banner.frame = CGRectMake(0, 0, SCREEN_WIDTH, bannerHeight);
//    banner.backgroundColor = [UIColor greenColor];
//    [body addSubview:banner];
//    
//    UIScrollView *bscrollView = [UIScrollView new];
//    bscrollView.frame = CGRectMake(0, bannerHeight, SCREEN_WIDTH, body.height-bannerHeight);
//    bscrollView.tag = 100;
//    bscrollView.delegate = self;
//    bscrollView.backgroundColor = [UIColor lightGrayColor];
//    bscrollView.decelerationRate = 0;
//    bscrollView.pagingEnabled = YES;
//    bscrollView.bounces = NO;
//    [body addSubview:bscrollView];
//    
//    bscrollView.contentSize = CGSizeMake(SCREEN_WIDTH*arrChild.count, 0);
//    
//    for(int i=0;i<arrChild.count;i++) {
//        SuperScrollViewController *vc = arrChild[i];
//        [self addChildViewController:vc];
//        
//        vc.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, bscrollView.height);
//        
//        [bscrollView addSubview:vc.view];
//        
//        vc.superScrollView = bscrollView;
//    }
    
//    atableView.scrollEnabled = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    

    if(99 == scrollView.tag) {
        CGFloat offsetY = scrollView.contentOffset.y;
        [self resetHeightWithY:offsetY];
    }
    
    
}

- (void)resetHeightWithY:(float)offsetY {
//    body.height = BODY_HEIGHT - headerHeight + offsetY;
    
    
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
