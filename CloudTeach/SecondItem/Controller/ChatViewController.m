//
//  ChatViewController.m
//  CloudTeach
//
//  Created by tiny on 17/3/28.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "ChatViewController.h"
#import "BaseChatCell.h"
#import "TextCell.h"
#import "ImageCell.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arrMessage;
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"消息";
    self.leftButton.hidden = NO;
    
    TextMessage *t = [TextMessage new];
    t.msgDirect = message_direct_self;
    t.text = @"this is a test message";
    t.sender = @"tiny";
    t.type = message_text;
    
    TextMessage *b = [TextMessage new];
    b.msgDirect = message_direct_other;
    b.text = @"我不是知道撒是你说的话哈哈哈哈哈哈哈，你到底了李连杰1啊实打实的";
    b.sender = @"tiny";
    b.type = message_text;
    
    ImageMessage *i = [ImageMessage new];
    i.msgDirect = message_direct_other;
    i.imageUrl = @"http://oi9r0ivj6.bkt.clouddn.com/头像120x120.png";
    i.sender = @"fish";
    i.type = message_image;
    
    TextMessage *a = [TextMessage new];
    a.msgDirect = message_direct_self;
    a.text = @"this is a test message http://oi9r0ivj6.bkt.clouddn.com/头像120x120.png this is a test message http://oi9r0ivj6.bkt.clouddn.com/头像120x120.png";
    a.sender = @"tiny";
    a.type = message_text;
    
    ImageMessage *c = [ImageMessage new];
    c.msgDirect = message_direct_self;
    c.imageUrl = @"http://oi9r0ivj6.bkt.clouddn.com/头像120x120.png";
    c.sender = @"fish";
    c.type = message_image;
    
    arrMessage = @[t,b,i,c,a];
    
    [self initTableView];
    [self initTextField];
}

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStyleGrouped];
    tableView.backgroundColor = HEX_RGB(0xffffff);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)initTextField {
    UIView *viewBottom = [UIView new];
    viewBottom.frame  =CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
    viewBottom.backgroundColor = HEX_RGB(0xececec);
    [self.view addSubview:viewBottom];
    
    UITextField *tfMessage = [UITextField new];
    tfMessage.frame = CGRectMake(10, 10, viewBottom.width-90, 40);
    tfMessage.placeholder = @"请输入...";
    tfMessage.borderStyle = UITextBorderStyleRoundedRect;
    [viewBottom addSubview:tfMessage];
    
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSend.frame = CGRectMake(viewBottom.width-70, 11, 60, 38);
    btnSend.backgroundColor = BASE_COLOR;
    btnSend.layer.cornerRadius = 5;
    [btnSend setTitleColor:HEX_RGB(0xffffff) forState:UIControlStateNormal];
    [btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [viewBottom addSubview:btnSend];
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arrMessage.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseMessage *message = arrMessage[indexPath.section];
    Class messageClass = [self getClassFromMessage:message];
    
    float height = [messageClass cellHeightFromMessage:message];
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseMessage *message = arrMessage[indexPath.section];
    Class messageClass = [self getClassFromMessage:message];
    
    NSString *cellId = @"cell";
    BaseChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell) {
        
        cell = [[messageClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [cell setCellContent:message withIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:indexPath];
}

- (Class)getClassFromMessage:(BaseMessage *)message {
    NSDictionary *dicMessageType = @{@(message_text):@"TextCell"
                                     ,@(message_image):@"ImageCell"};
    NSString *className = nil;
    className = dicMessageType[@(message.type)];
    
    Class messageClass = nil;
    messageClass = NSClassFromString(className);
    
    return messageClass;
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
