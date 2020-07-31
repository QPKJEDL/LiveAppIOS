//
//  MomentDataProcess.m
//  zhibo
//
//  Created by qp on 2020/7/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MomentDataProcess.h"

@implementation MomentDataProcess
/// Called to modify a request before sending.
- (ABNetRequest *)prepare:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_MOMENTS_LIST]) {
        if (request.params[@"live_uid"] != nil) {
            request.realUri = @"/live_zone_list";
        }else{
            request.realUri = @"/all_zone_list";
        }
    }
    if ([request.uri isEqualToString:URI_MOMENTS_PUBLISH]) {
        request.realUri = @"/code/Mycenter/zone";
    }
    if ([request.uri isEqualToString:URI_MOMENTS_COMMENTS]) {
        request.realUri = @"/live_zone_comment_list";
    }
    if ([request.uri isEqualToString:URI_MOMENTS_COMMENT_SEND]) {
        request.realUri = @"/live_zone_comment";
    }
    if ([request.uri isEqualToString:URI_MOMENTS_COMMENT_REPLY]) {
        request.realUri = @"/live_zone_reply";
    }
    if ([request.uri isEqualToString:URI_MOMENTS_LIKE]) {
        request.realUri = @"/live_zone_thumb";
    }
    if ([request.uri isEqualToString:URI_MOMENTS_COMMENT_DELETE]) {
        request.realUri = @"/live_zone_comment_del";
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    NSArray *noLoadings = @[URI_MOMENTS_LIST];
    if ([noLoadings containsObject:request.uri] == false) {
        [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
    }
    
    return true;
}

/// Called immediately before a request is sent over the network (or stubbed).
- (void)willSend:(ABNetRequest *)request {
    [ABUITips showLoading];
}

/// Called to modify a result before completion.
- (void)didReceive:(ABNetRequest *)request response:(NSDictionary *)response {
    
}

/// Called to modify a result before completion.
- (NSDictionary *)process:(ABNetRequest *)request response:(NSDictionary *)response {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
    if ([request.uri isEqualToString:URI_MOMENTS_LIST]) {
        NSMutableArray *list = response[@"list"];
        list = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            
            CGFloat height = 84+44;
            
            NSString *createtime = [NSString stringWithFormat:@"%@", dic[@"creatime"]];
            NSString *content = [NSString stringWithFormat:@"%@", dic[@"content"]];
            if (content.length > 0) {
                CGSize contentSize = [content sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)];
                height = height+contentSize.height+17;
                
                dic[@"contentw"] = @(SCREEN_WIDTH-30);
                dic[@"contenth"] = @(contentSize.height);
            }

            dic[@"time"] = [[ABTime shared] howMuchTimePassed:createtime];
            dic[@"avatar"] = dic[@"avater"];
            dic[@"native_id"] = @"momentitem";
            dic[@"item.size.height"] = @(height);
            dic[@"like_count"] = [dic stringValueForKey:@"thumb_num"];
            dic[@"comment_count"] = [dic stringValueForKey:@"comment_num"];
            if (dic[@"live_uid"] == nil) {
                dic[@"live_uid"] = request.params[@"live_uid"];
            }
            dic[@"content"] = content;
            return dic;
        }];
        return @{@"list":list};
    }
    
    if ([request.uri isEqualToString:URI_MOMENTS_COMMENTS]) {
        NSArray *list = [ABIteration iterationList:response[@"list"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            NSString *comment = dic[@"comment"];
            
            CGSize commentSize = [comment sizeWithFont:[UIFont PingFangSC:15] constrainedToSize:CGSizeMake(SCREEN_WIDTH-75, MAXFLOAT)];
            
            NSString *reply = dic[@"reply"];
            CGFloat replyw = SCREEN_WIDTH-75;
            CGFloat replyh = 0;
            
            NSMutableArray *replys = [[NSMutableArray alloc] init];
            if (reply.length > 0) {
                CGSize replySize = [reply sizeWithFont:[UIFont PingFangSC:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH-75-20, MAXFLOAT)];
                
                
                CGFloat h = replySize.height+35;
                NSDictionary *replyitem = @{
                    @"avater":request.params[@"avatar"],
                    @"nickname":request.params[@"nick"],
                    @"comment":reply,
                    @"commentw":@(replySize.width),
                    @"commenth":@(replySize.height),
                    @"creatime":dic[@"savetime"],
                    @"native_id":@"commentitemreply",
                    @"item.size.height":@(h)
                };
                [replys addObject:replyitem];
                replyh+=h;
                dic[@"replys"] = replys;
            }

            dic[@"commentw"] = @(commentSize.width);
            dic[@"commenth"] = @(commentSize.height);
            
            dic[@"replyw"] = @(replyw);
            dic[@"replyh"] = @(replyh);
            dic[@"item.size.height"] = @(commentSize.height+20+30+replyh);
            dic[@"native_id"] = @"commentitem";
            return dic;
        }];
        return @{@"list":list, @"totalcount":[response stringValueForKey:@"commSum"]};
    }
    return response;
}

- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
@end
