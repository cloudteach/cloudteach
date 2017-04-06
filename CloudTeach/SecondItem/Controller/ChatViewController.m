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

#import "HPPForTableViewController.h"
#import "HPPForCollectionViewController.h"
#import "HPPNavigationController.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextField *tfMessage;
    UIView *viewBottom;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *marrMessage;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [NSString stringWithFormat:@"与 %@ 聊天中",_currentContact.name];
    self.leftButton.hidden = NO;
    
    [self getSession];
    
    self.tableView.hidden = NO;
    [self initTextField];
    
    [self initNotification];
}

- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"didReceiveMessage"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessage:) name:@"didReceiveMessage" object:nil];
}

- (NSMutableArray *)marrMessage {
    if(!_marrMessage) {
        _marrMessage = [NSMutableArray array];
    }
    return _marrMessage;
}

- (void)getSession {
    if(!_currentConversation) {
        _currentConversation = [[EMClient sharedClient].chatManager getConversation:_currentContact.name type:EMConversationTypeChat createIfNotExist:YES];
    }
    [self getLocalHistoryMessage];
}

- (void)getLocalHistoryMessage {
    [_currentConversation loadMessagesFrom:0 to:[[NSDate date] timeIntervalSince1970]*1000 count:100 completion:^(NSArray *aMessages, EMError *aError) {
        [self.marrMessage addObjectsFromArray:aMessages];
        [self tableRefreshAndScrollToBottom:NO];
    }];
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-60) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = HEX_RGB(0xffffff);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)initTextField {
    viewBottom = [UIView new];
    viewBottom.frame = CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
    viewBottom.backgroundColor = HEX_RGB(0xececec);
    [self.view addSubview:viewBottom];
    
    tfMessage = [UITextField new];
    tfMessage.frame = CGRectMake(10, 10, viewBottom.width-68, 40);
    tfMessage.delegate = self;
    tfMessage.placeholder = @"请输入...";
    tfMessage.borderStyle = UITextBorderStyleRoundedRect;
    tfMessage.returnKeyType = UIReturnKeyDone;
    [viewBottom addSubview:tfMessage];
    
    UIButton *btnSelect = [UIButton buttonWithType:UIButtonTypeSystem];
    btnSelect.frame = CGRectMake(viewBottom.width - 48, 11, 38, 38);
    btnSelect.backgroundColor = BASE_COLOR;
    btnSelect.layer.cornerRadius = 38/2;
    [btnSelect setTitleColor:HEX_RGB(0xffffff) forState:UIControlStateNormal];
    [btnSelect setTitle:@"➕" forState:UIControlStateNormal];
    [btnSelect addTarget:self action:@selector(openLibrary) forControlEvents:UIControlEventTouchUpInside];
    [viewBottom addSubview:btnSelect];
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
    return _marrMessage.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseMessage *message = _marrMessage[indexPath.section];
    Class messageClass = [self getClassFromMessage:message];
    
    float height = [messageClass cellHeightFromMessage:message];
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseMessage *message = _marrMessage[indexPath.section];
    Class messageClass = [self getClassFromMessage:message];
    
    NSString *cellId = [NSString stringWithFormat:@"%@",messageClass];
    BaseChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell) {
        cell = [[messageClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell setCellContent:message withIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:indexPath];
}

- (Class)getClassFromMessage:(BaseMessage *)message {
    NSDictionary *dicMessageType = @{@(EMMessageBodyTypeText):@"TextCell"
                                     ,@(EMMessageBodyTypeImage):@"ImageCell"
                                     ,@(EMMessageBodyTypeVideo):@"ImageCell"
                                     ,@(EMMessageBodyTypeLocation):@"ImageCell"
                                     ,@(EMMessageBodyTypeVoice):@"ImageCell"
                                     ,@(EMMessageBodyTypeFile):@"ImageCell"
                                     ,@(EMMessageBodyTypeCmd):@"ImageCell"
                                     };
    NSString *className = nil;

    className = dicMessageType[@(message.body.type)];
    
    Class messageClass = nil;
    messageClass = NSClassFromString(className);
    
    return messageClass;
}

- (void)openLibrary {
    //set up fetch options, mediaType is image.
    

}

- (void)didReceiveMessage:(NSNotification *)userInfo {
    NSArray *arrNewMessage = userInfo.object;
    
    for(EMMessage *message in arrNewMessage) {
        if([message.from isEqualToString:_currentContact.name]) {
            [self.marrMessage addObject:message];
        }
    }
    [self tableRefreshAndScrollToBottom:YES];
}

- (void)makeTextMessage {
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:tfMessage.text];
    
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:_currentConversation.conversationId from:from to:_currentContact.name body:body ext:_currentConversation.ext];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
    [self sendMessage:message];
}

- (void)makeImageMessage:(NSData *)data {
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:@"image.png"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:_currentConversation.conversationId from:from to:_currentContact.name body:body ext:_currentConversation.ext];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
    [self sendMessage:message];
}

- (void)sendMessage:(EMMessage *)message {
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        NSLog(@"");
    } completion:^(EMMessage *message, EMError *error) {
        if(!error && message) {
            [self.marrMessage addObject:message];
            [self tableRefreshAndScrollToBottom:YES];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.text.length) {
        [self makeTextMessage];
    }

    tfMessage.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)tableRefreshAndScrollToBottom:(BOOL)animation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self scrollToBottom:animation];
    });
}

- (void)scrollToBottom:(BOOL)animation {
    //判断tableView是否滑动到底部 如果没有 则滑动到底部
    CGPoint contentOffsetPoint = self.tableView.contentOffset;
    CGRect frame = self.tableView.frame;
    if(contentOffsetPoint.y == self.tableView.contentSize.height-frame.size.height || self.tableView.contentSize.height < frame.size.height)
    {
        NSLog(@"scrolled end");
    }else
    {
        CGPoint bottomPoint = CGPointMake(0,self.tableView.contentSize.height-frame.size.height);
        [self.tableView setContentOffset:bottomPoint animated:animation];
    }
}

#pragma mark keyboardNotifications
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSValue *endFrameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endFrame = [endFrameValue CGRectValue];
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = viewBottom.frame;
        frame.origin.y -= endFrame.size.height;
        viewBottom.frame = frame;
    }];
}

//- (void)keyboardWillChangeFrame:(NSNotification *)notification {
//    CGFloat bottomBarY = SCREEN_HEIGHT - 49;
//    if (_editingCommentTextField) {
//        NSDictionary *userInfo = notification.userInfo;
//        NSValue *endFrameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//        CGRect endFrame = [endFrameValue CGRectValue];
//        _bottomBar.frame = CGRectMake(0, bottomBarY - endFrame.size.height, SCREEN_WIDTH, 49);
//    }
//}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = viewBottom.frame;
        frame.origin.y = SCREEN_HEIGHT - 60;
        viewBottom.frame = frame;
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
