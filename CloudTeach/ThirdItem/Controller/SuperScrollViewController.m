//
//  SuperScrollViewController.m
//  CloudTeach
//
//  Created by tiny on 17/4/5.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperScrollViewController.h"

@interface SuperScrollViewController ()<UIScrollViewDelegate>

@end

@implementation SuperScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.superScrollView.delegate = self;
    self.isHeaderShow = YES;
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.isHeaderShow) {
        if(!self.isCanScroll){
            //只有在父视图没有偏移，并且向下滑动的时候才不重置偏移量，此时需要下拉刷新
            if (self.superScrollView.contentOffset.y > 0)
            {
                [scrollView setContentOffset:CGPointZero];
            }
            else
            {
                if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < 5)
                {
                    [scrollView setContentOffset:CGPointZero];
                }
            }
            
            CGFloat offsetY = scrollView.contentOffset.y;
            
            if (offsetY < 0 && self.isCanScroll)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"teamDetailLeaveTop" object:nil userInfo:@{@"canScroll":@"1"}];
            }
        }
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
