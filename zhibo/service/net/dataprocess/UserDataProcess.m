//
//  UserDataProcess.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UserDataProcess.h"

@implementation UserDataProcess
/// Called to modify a request before sending.
- (ABNetRequest *)prepare:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_USER_INFO]) {
        request.realUri = @"/ToUserinfo";
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
