//
//  AccountDataProcess.m
//  zhibo
//
//  Created by qp on 2020/6/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AccountDataProcess.h"

@implementation AccountDataProcess
/// Called to modify a request before sending.
- (ABNetRequest *)prepare:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_ACCOUNT_LOGIN]) {
        request.realUri = @"/login";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_INFO]) {
        request.realUri = @"/user_balance";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_REGISTER]) {
        request.realUri = @"/register";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_FORGET_LOGIN]) {
        request.realUri = @"/login_pwd";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_FORGET_RECHARGE]) {
        request.realUri = @"/draw_pwd";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_EDIT_NICKNAME]) {
        request.realUri = @"/change_nickname";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_INFO]) {
        request.realUri = @"/Userinfo";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BIND_WECHAT]) {
        request.realUri = @"/wx_bind";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BIND_ALIPAY]) {
        request.realUri = @"/ali_bind";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_CASHOUT]) {
        
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_RECHARGE]) {
        
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_CHANGER_LIST]) {
        request.realUri = @"/account_changer_list";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_LOWERS]) {
        request.realUri = @"/TeamList";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_STATIS]) {
    //        request.realUri = @"";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_POPULARIZE_CODELIST]) {
        
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_CASHOUT]) {
        return false;
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_RECHARGE]) {
        return false;
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_STATIS]) {
         return false;
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_POPULARIZE_CODELIST]) {
        return false;
    }
    return true;
}

/// Called immediately before a request is sent over the network (or stubbed).
- (void)willSend:(ABNetRequest *)request {
    
}

/// Called to modify a result before completion.
- (void)didReceive:(ABNetRequest *)request response:(NSDictionary *)response {
    
}

/// Called to modify a result before completion.
- (NSDictionary *)process:(ABNetRequest *)request response:(NSDictionary *)response {
    NSArray *paychannels = @[
        @{@"title":@"微信支付", @"icon":@"weixin", @"native_id":@"paychannel"},
        @{@"title":@"支付宝支付", @"icon":@"zhifubao", @"native_id":@"paychannel"},
        @{@"title":@"银行卡支付", @"icon":@"yinlian", @"native_id":@"paychannel"}
    ];
    
    NSDictionary *css  = @{
        @"item.size.width":@"100%",
        @"item.size.height":@"60",
    };
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_CASHOUT]) {
        return @{@"css":css, @"items":paychannels};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_RECHARGE]) {
        NSArray *numbers = @[@"20", @"30", @"50", @"80", @"100"];
        NSMutableArray *numberItems = [[NSMutableArray alloc] init];
        for (int i=0; i<numbers.count; i++) {
            NSInteger num = [numbers[i] intValue];
            NSString *dou = [NSString stringWithFormat:@"直播豆%ld", num*2];
            [numberItems addObject:@{
                @"number":numbers[i],
                @"dou":dou,
                @"native_id":@"moneyitem"
            }];
        }
        
        NSArray *pays = @[
            @{@"title":@"微信支付", @"icon":@"weixin", @"native_id":@"paychannel"},
            @{@"title":@"支付宝支付", @"icon":@"zhifubao", @"native_id":@"paychannel"},
            @{@"title":@"银行卡支付", @"icon":@"yinlian", @"native_id":@"paychannel"}
        ];
        
        CGFloat w = floor((SCREEN_WIDTH-14)/3);
        NSArray *list = @[
            @{
                @"css":@{
                        @"item.size.width":@(w),
                        @"item.size.height":@"68",
                        @"header.size.height":@"44",
                        @"header.size.width":@"100%",
                        @"section.inset.left":@(7),
                        @"section.inset.right":@(7),
                },
                @"header":@{
                           @"title":@"充值金额",
                           @"native_id":@"moneysectionheader"
                       },
                @"items":numberItems
            },
            @{
                @"css":@{
                        @"item.size.width":@"100%",
                        @"item.size.height":@"60",
                        @"header.size.height":@"44",
                        @"header.size.width":@"100%"
                },
                @"header":@{
                           @"title":@"充值方式",
                           @"native_id":@"moneysectionheader"
                       },
                @"items":pays
            },
        ];
        return @{@"list":list};
    }
    
    if ([request.uri isEqualToString:URI_ACCOUNT_CHANGER_LIST]) {
        NSArray *list = response[@"list"];
        list = @[
            @{
                @"creatime":@"1592410495",
                @"id":@1,
                @"money":@1000
            },
            @{
                @"creatime":@"1593410495",
                @"id":@1,
                @"money":@2000
            },
            @{
                @"creatime":@"1593410195",
                @"id":@1,
                @"money":@100
            },
            @{
                @"creatime":@"1593420495",
                @"id":@1,
                @"money":@5000
            }
        ];
        list = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"native_id"] = @"chargeitem";
            return dic;
        }];
        return @{@"list":list};
    }
    
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_LOWERS]) {
        NSArray *list = [ABIteration iterationList:response[@"list"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"avatar"] = dic[@"avater"];
            dic[@"native_id"] = @"loweritem";
            return dic;
        }];
//        NSArray *list = @[
//
//            @{
//                @"avatar":@"http://cdn.duitang.com/uploads/item/201507/11/20150711140831_KLCfd.jpeg",
//                @"nickname":@"米雪儿",
//                @"native_id":@"loweritem"
//            },
//            @{
//                @"avatar":@"http://cdn.duitang.com/uploads/item/201507/11/20150711140831_KLCfd.jpeg",
//                @"nickname":@"李兴奥",
//                @"native_id":@"loweritem"
//            }
//
//        ];
        return @{@"list":list, @"count":@(0)};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_STATIS]) {
        return @{
            @"list":@[
                @{
                    @"title":@"注册人数",
                    @"content":@"1083人",
                    @"native_id":@"statisitem"
                },
                @{
                    @"title":@"投注人数",
                    @"content":@"1083人",
                    @"native_id":@"statisitem"
                },
                @{
                    @"title":@"投注金额",
                    @"content":@"1083人",
                    @"native_id":@"statisitem"
                },
                @{
                    @"title":@"中奖金额",
                    @"content":@"1083人",
                    @"native_id":@"statisitem"
                },
                @{
                    @"title":@"充值金额",
                    @"content":@"1083人",
                    @"native_id":@"statisitem"
                },
                @{
                    @"title":@"下级返点金额",
                    @"content":@"1083人",
                    @"native_id":@"statisitem"
                },
                @{
                    @"title":@"团队返点金额",
                    @"content":@"1083人",
                    @"native_id":@"statisitem"
                },
                @{
                    @"title":@"我的饭店金额",
                    @"content":@"1083人",
                    @"native_id":@"statisitem"
                }
            ]
        };
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_POPULARIZE_CODELIST]) {
        NSArray *list = @[
            @{
                @"time":[ABTime time],
                @"native_id":@"popularizecodeitem"
            }
        ];
        return @{@"list":list};
    }
    return response;
}
@end
