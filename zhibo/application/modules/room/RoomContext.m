//
//  RoomContext.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomContext.h"

@implementation RoomContext
+ (RoomContext *)shared {
    static RoomContext *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.banlist = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
