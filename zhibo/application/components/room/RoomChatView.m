//
//  RoomChatView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomChatView.h"
#import "RoomComeRaw.h"
@interface RoomChatView ()<ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) RoomComeRaw *comeRaw;

@property (nonatomic, assign) NSInteger messageCount;
@property (nonatomic, strong) UIButton *messageButton;
@end
@implementation RoomChatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataList = [[NSMutableArray alloc] init];
        
//        self.comeRaw = [[RoomComeRaw alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
//        [self.comeRaw addTarget:self action:@selector(onComeRaw) forControlEvents:UIControlEventTouchUpInside];
        
        _listView = [[ABUIListView alloc] initWithFrame:self.bounds];
//        self.listView.footerView = self.comeRaw;
        _listView.collectionView.showsVerticalScrollIndicator = false;
        _listView.collectionView.showsHorizontalScrollIndicator = false;
        _listView.dynamicContent = true;
        _listView.delegate = self;
        [self addSubview:_listView];
        
        self.messageButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.messageButton.top = self.height-26;
        [self.messageButton setBackgroundColor:[UIColor whiteColor]];
        self.messageButton.titleLabel.font = [UIFont PingFangSC:13];
        [self.messageButton addTarget:self action:@selector(onMessageButton) forControlEvents:UIControlEventTouchUpInside];
        [self.messageButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        self.messageCount = 0;
    }
    return self;
}

- (void)onMessageButton {
    [self scrollToBottom];
}

- (void)receiveNewMessage:(NSDictionary *)message {
    self.messageCount++;
    [self.dataList addObject:message];
    [self.listView setDataList:self.dataList css:@{
        @"item.rowSpacing":@"10"
    }];

}

- (void)receiveNewNotice:(NSDictionary *)notice {
//    [self.comeRaw showWithData:notice];
}


- (void)listViewDidReload:(ABUIListView *)listView {
    if ([self.listView isInBottom] == false) {
        if (self.messageButton.superview == nil) {
            [self addSubview:self.messageButton];
        }
        [self.messageButton setTitle:[NSString stringWithFormat:@"%li条新消息", (long)self.messageCount] forState:UIControlStateNormal];
        [self.messageButton sizeToFit];
        self.messageButton.height = 26;
        self.messageButton.layer.cornerRadius = 26/2;
        self.messageButton.width = self.messageButton.width+20;
    }else{
        [self scrollToBottom];
    }
}

- (void)scrollToBottom {
    self.messageCount = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.messageCount = 0;
        [self.listView scrollToBottom:true];
        [self.messageButton removeFromSuperview];
    });
}

- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *css = self.dataList[indexPath.row][@"css"];
    
    return CGSizeMake(self.width, [css[@"h"] floatValue]+20);
}

- (void)listView:(ABUIListView *)listView onContentSizeChanged:(CGSize)contentSize {
    if (contentSize.height < self.height) {
        self.listView.collectionView.contentInset = UIEdgeInsetsMake(self.height-contentSize.height, 0, 0, 0);
    }
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    [self.delegate roomChatView:self didSelectUid:[item[@"uid"] intValue]];
}


- (void)listViewDidScrollToBottom:(ABUIListView *)listView {
    self.messageCount = 0;
    [self.messageButton removeFromSuperview];
}

- (void)onComeRaw {
//    [RP promptUserWithUid:self.comeRaw.uid];
}

@end
