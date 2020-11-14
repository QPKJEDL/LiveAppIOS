//
//  RoomCenter.m
//  zhibo
//
//  Created by qp on 2020/11/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomCenter.h"

@implementation RoomCenter
+ (RoomCenter *)shared {
    static RoomCenter *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
