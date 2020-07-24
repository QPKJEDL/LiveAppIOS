//
//  RoomPushSocket.m
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPushSocket.h"

@implementation RoomPushSocket

- (void)applicationDidEnterBackground {
    [super applicationDidEnterBackground];
    [self sendText:@"主播暂时离开"];
}
@end
