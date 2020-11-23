//
//  MessagePresent.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MessagePresent.h"
@interface MessagePresent ()<INetData>
@end
@implementation MessagePresent

- (void)getMessageList:(NSInteger)tag {
    [ABUITips showLoading];
    [self fetchPostUri:URI_MESSAGE_LIST params:@{@"type":@(tag)}];
    
//    if (tag == 0) {
//        NSMutableArray *tmpList = [[NSMutableArray alloc] init];
//        NSArray *dataList = [ResourceUtil readDataWithFileName:@"messagelist"][@"data"];
//        for (NSDictionary *tmpItem in dataList) {
////            MessageItem *item = [[MessageItem alloc] init];
////            item.icon = tmpItem[@"icon"];
////            item.title = tmpItem[@"title"];
////            item.content = tmpItem[@"content"];
//
//              [tmpList addObject:tmpItem];
//        }
//
//        self.messageList = tmpList;
//        [self.delegate onReceiveMessageList];
//    }else{
//        NSMutableArray *tmpList = [[NSMutableArray alloc] init];
//        NSArray *dataList = [ResourceUtil readDataWithFileName:@"sysmessagelist"][@"data"];
//        for (NSDictionary *tmpItem in dataList) {
////            MessageItem *item = [[MessageItem alloc] init];
////            item.type = MessageTypeSystem;
////            item.time = [[TimeUtil shared] timestampToTime:tmpItem[@"time"]];
////            item.content = tmpItem[@"content"];
//
//            NSMutableDictionary *ttt = [[NSMutableDictionary alloc] initWithDictionary:tmpItem];
//            ttt[@"time"] = [[TimeUtil shared] timestampToTime:tmpItem[@"time"]];
//
//            NSString *content = tmpItem[@"content"];
//            CGFloat contentHeight = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)].height;
//            ttt[@"contentHeight"] = [NSNumber numberWithFloat:contentHeight];
//
//            CGFloat height = 35+contentHeight;
//            ttt[@"height"] = [NSNumber numberWithFloat:height];
//            [tmpList addObject:ttt];
//        }
//
//        self.messageList = tmpList;
//        [self.delegate onReceiveMessageList];
//    }
    
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    self.messageList = obj[@"list"];
    [self.delegate onReceiveMessageList];
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}

@end
