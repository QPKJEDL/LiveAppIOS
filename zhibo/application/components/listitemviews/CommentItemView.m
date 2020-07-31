//
//  CommentItemView.m
//  zhibo
//
//  Created by qp on 2020/7/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "CommentItemView.h"
@interface CommentItemView ()<INetData>
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) ABUIListView *replyListView;
@property (nonatomic, strong) NSDictionary *data;
@end
@implementation CommentItemView

- (void)setupAdjustContents {
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.clipsToBounds = true;
    self.avatarImageView.layer.cornerRadius = 34/2;
    [self addSubview:self.avatarImageView];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nickNameLabel.font = [UIFont PingFangMedium:14];
    self.nickNameLabel.textColor = [UIColor hexColor:@"868687"];
    [self addSubview:self.nickNameLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont PingFangSC:15];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.font = [UIFont PingFangSC:12];
    self.timeLabel.textColor = [UIColor hexColor:@"868687"];
    [self addSubview:self.timeLabel];
    
    self.replyListView = [[ABUIListView alloc] initWithFrame:CGRectMake(60, 0, self.width-75, 44)];
//    self.replyListView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.replyListView];
    
    UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    ges.minimumPressDuration = 1;
    [self addGestureRecognizer:ges];
}

- (void)longPress:(UILongPressGestureRecognizer *)sender{
    if (self.data[@"live_uid"] != [Service shared].account.uid) {
        return;
    }
    //进行判断,在什么时候触发事件
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按状态");
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {

        }];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"删除" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [self fetchPostUri:URI_MOMENTS_COMMENT_DELETE params:self.data];
        }];
        QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"举报" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            
        }];

        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:nil message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
        alertController.alertTextFieldTextColor = [UIColor redColor];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:action3];
        [alertController showWithAnimated:YES];
    }
}


- (void)layoutAdjustContents {
    self.avatarImageView.left = 15;
    self.nickNameLabel.centerY = self.avatarImageView.height/4;
    self.nickNameLabel.left = self.avatarImageView.right+10;
    
    self.contentLabel.left = self.nickNameLabel.left;
    self.contentLabel.top = self.avatarImageView.bottom+2;
    
    self.timeLabel.left = self.nickNameLabel.left;
    self.timeLabel.top = self.nickNameLabel.bottom;
    self.replyListView.top = self.contentLabel.bottom+5;
}

- (void)reload:(NSDictionary *)item {
    self.data = item;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item[@"avater"]] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.nickNameLabel.text = item[@"nickname"];
    [self.nickNameLabel sizeToFit];
    
    self.contentLabel.text = item[@"comment"];
//    [self.contentLabel sizeToFit];
    self.contentLabel.width = [item[@"commentw"] floatValue];
    self.contentLabel.height = [item[@"commenth"] floatValue];
    
    NSString *creatime = item[@"creatime"];
    self.timeLabel.text = [[ABTime shared] howMuchTimePassed:creatime];
    [self.timeLabel sizeToFit];
    
    [self.replyListView setHidden:true];
    if (item[@"replys"]) {
        self.replyListView.height = [item[@"replyh"] floatValue];
        [self.replyListView setHidden:false];
        [self.replyListView setDataList:item[@"replys"] css:nil];
    }
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [ABUITips showSucceed:@"删除成功"];
    [[ABMQ shared] publish:@"" channel:CHANNEL_COMMENT_CHANGED];
}

@end
