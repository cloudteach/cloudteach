//
//  MessageViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/27.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"

#import "ChatViewController.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *marrConversation;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hidden = NO;
    
    [self getAllConversations];
    // Do any additional setup after loading the view.
}

- (void)getAllConversations {
//    [self.marrConversation addObjectsFromArray:[[EMClient sharedClient].chatManager getAllConversations]];
    NSArray *arrConversation = [[EMClient sharedClient].chatManager getAllConversations];
    for(EMConversation *conversation in arrConversation) {
        if(![conversation.conversationId isEqualToString:[[EMClient sharedClient] currentUsername]]) {
            [self.marrConversation addObject:conversation];
        }
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-10) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return  _tableView;
}

- (NSMutableArray *)marrConversation {
    if(!_marrConversation) {
        _marrConversation = [NSMutableArray array];
    }
    return _marrConversation;
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _marrConversation.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    EMConversation *conversation = _marrConversation[indexPath.row];
    if(!cell) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [cell setCellContent:conversation withIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChatViewController *chatVC = [ChatViewController new];
    EMConversation *conversation = _marrConversation[indexPath.row];
    chatVC.currentConversation = conversation;
    Contact *contact = [[Contact alloc] initContactWithName:conversation.conversationId];
    chatVC.currentContact = contact;
    [self.navigationController pushViewController:chatVC animated:YES];
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
