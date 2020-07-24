//
//  MessageViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MessageViewController.h"
#import "MessagePresent.h"
@interface MessageViewController ()<MessagePresentDelegate, ABUIListViewDelegate>
@property (nonatomic, strong) MessagePresent *messagePresent;
@property (nonatomic, strong) ABUIListView *listView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    
    self.messagePresent = [[MessagePresent alloc] init];
    self.messagePresent.delegate = self;
    
    [self.messagePresent getMessageList:[self.props[@"type"] intValue]];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    NSString *icon = item[@"icon"];
    if ([icon  isEqual: @"gonggao"]) {
        [NSRouter gotoMessagePage:1];
    }
}

//- (CGFloat)listView:(ListView *)listView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 70;
//}
//
//- (void)listView:(ListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *item = self.dataList[indexPath.row];
//    NSString *icon = item[@"icon"];
//    if ([icon  isEqual: @"gonggao"]) {
//        [NSRouter gotoMessagePage:1];
//    }
//    else if ([icon  isEqual: @"xiaoxi2"]) {
//        [NSRouter gotoMessagePage:2];
//    }
//    else if ([icon hasPrefix:@"kefu"]) {
//
//    } else {
//        [NSRouter gotoChatPage];
//    }
//}

- (void)onReceiveMessageList {
//    self.dataList = self.messagePresent.messageList;
    [self.listView reloadData];
    [self.listView setDataList:self.messagePresent.messageList css:nil];
}

- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = [self.messagePresent.messageList[indexPath.row][@"h"] floatValue];
    return CGSizeMake(SCREEN_WIDTH, h+28+20+3);
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
