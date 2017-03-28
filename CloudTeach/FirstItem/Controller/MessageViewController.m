//
//  MessageViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arrHeaderItem;
}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"消息";
    
    arrHeaderItem = @[@"发作业",@"已发作业",@"待定",@"待定"];
    
    
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, BODY_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrHeaderItem.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [cell setCellContent:@"" withIndexPath:indexPath];
    }
    
    
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
