//
//  MessagePresent.h
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MessagePresentDelegate <NSObject>

- (void)onReceiveMessageList;

@end

@interface MessagePresent : NSObject
@property (nonatomic, weak) id<MessagePresentDelegate> delegate;
@property (nonatomic, strong) NSArray *messageList;
- (void)getMessageList:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
