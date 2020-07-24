//
//  FollowDataProcess.m
//  zhibo
//
//  Created by qp on 2020/7/8.
//  Copyright © 2020 qp. All rights reserved.
//

#import "FollowDataProcess.h"

@implementation FollowDataProcess
/// Called to modify a request before sending.
- (ABNetRequest *)prepare:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_FOLLOW_LIST]) {
        request.realUri = @"/follow_list";
    }
    if ([request.uri isEqualToString:URI_FOLLOW_FOLLOW]) {
        request.realUri = @"/do_follow_live";
    }
    if ([request.uri isEqualToString:URI_FOLLOW_UNFOLLOW]) {
        request.realUri = @"/un_follow_live";
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    return true;
}

/// Called immediately before a request is sent over the network (or stubbed).
- (void)willSend:(ABNetRequest *)request {
    
}


- (void)endSend:(ABNetRequest *)request {
    
}
/// Called to modify a result before completion.
- (void)didReceive:(ABNetRequest *)request response:(NSDictionary *)response {
    
}

/// Called to modify a result before completion.
- (NSDictionary *)process:(ABNetRequest *)request response:(NSDictionary *)response {
    return response;
}
- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
   
}
@end
