//
//  CommentView.m
//  zhibo
//
//  Created by qp on 2020/7/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "CommentView.h"
#import "ZBInputView.h"
@interface CommentView ()<INetData, ZBInputViewDelegate, ABUIListViewDelegate, IABMQSubscribe>
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger live_uid;
@property (nonatomic, assign) NSInteger zone_id;

@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) ZBInputView  *inputView;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger comm_id;


@end
@implementation CommentView

+ (CommentView *)shared {
    static CommentView *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.6)];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexColor:@"F7F9FD"];
        
        CGFloat safeHeight = IS_iPhoneX?34:0;
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-safeHeight)];
        [self.containView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.containView];
        [self.containView corner:UIRectCornerTopLeft|UIRectCornerTopRight radii:20];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont PingFangSC:12];
        self.titleLabel.textColor = [UIColor hexColor:@"222222"];
        [self.containView addSubview:self.titleLabel];
        
        
        self.listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 31, self.width, self.containView.height-31-44)];
        self.listView.delegate = self;
        [self.containView addSubview:self.listView];
        
        self.inputView = [[ZBInputView alloc] initWithFrame:CGRectMake(0, self.containView.height-44, self.width, 44)];
        self.inputView.delegate = self;
        [self.containView addSubview:self.inputView];
    
        
        [[ABMQ shared] subscribe:self channel:CHANNEL_COMMENT_CHANGED autoAck:true];
    }
    return self;
}

- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
    [self refreshData];
}

- (void)onInput {
    
}

- (void)loadData:(NSInteger)live_uid zone_id:(NSInteger)zone_id {
    self.live_uid = live_uid;
    self.zone_id = zone_id;
    [self refreshData];
}

- (void)refreshData {
    [self fetchPostUri:URI_MOMENTS_COMMENTS params:@{@"zone_id":@(self.zone_id), @"lastid":@0, @"live_uid":@(self.live_uid), @"avatar":self.data[@"avatar"], @"nick":self.data[@"nickname"]}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_MOMENTS_COMMENTS]) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@条评论", obj[@"totalcount"]];
        NSArray *list = obj[@"list"];
        if (list.count == 0) {
            
        }else{
            [self.listView setDataList:list css:nil];
        }
    }

    if ([req.uri isEqualToString:URI_MOMENTS_COMMENT_SEND]) {
        [ABUITips showSucceed:@"评论成功"];
        [self refreshData];
        [[ABMQ shared] publish:@"" channel:CHANNEL_COMMENT_CHANGED];
    }
    
    if ([req.uri isEqualToString:URI_MOMENTS_COMMENT_REPLY]) {
        [ABUITips showSucceed:@"回复成功"];
        [self refreshData];
    }

}

- (void)zbInputView:(ZBInputView *)zbinputView text:(NSString *)text {
    if ([self.inputView.textView.placeholder containsString:@"回复"] == false) {
        [self fetchPostUri:URI_MOMENTS_COMMENT_SEND params:@{@"live_uid":@(self.live_uid), @"zone_id":@(self.zone_id), @"comment":text}];
    }else{
        [self fetchPostUri:URI_MOMENTS_COMMENT_REPLY params:@{@"live_uid":@(self.live_uid), @"zone_id":@(self.zone_id), @"reply":text, @"user_id":@(self.user_id), @"comm_id":@(self.comm_id)}];
    }
    
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (self.live_uid != [Service shared].account.uid) {
        return;
    }
    self.inputView.textView.placeholder = [NSString stringWithFormat:@"回复@%@", item[@"nickname"]];
    self.user_id = [item[@"user_id"] intValue];
    self.comm_id = [item[@"comm_id"] intValue];
    [self.inputView becomeFirstResponder];
}

@end
