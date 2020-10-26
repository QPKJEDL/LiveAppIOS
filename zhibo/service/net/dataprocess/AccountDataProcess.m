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
        if (request.params[@"code"] == nil) {
            request.realUri = @"/login";
        }else{
            request.realUri = @"/Codelogin";
        }
        
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
    if ([request.uri isEqualToString:URI_ACCOUNT_BIND_CARD]) {
        request.realUri = @"/bank_bind";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_CASHOUT]) {
        
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_RECHARGE_CHANNELS]) {
        request.realUri = @"/code/Mycenter/czlist";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_RECHARGE]) {
        request.realUri = @"/code/Mycenter/chongzhi";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_CHANGER_LIST]) {
        request.realUri = @"/account_changer_list";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_LOWERS]) {
        request.realUri = @"/TeamList";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_STATIS]) {
            request.realUri = @"/TeamListInfo";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_POPULARIZE_CODELIST]) {
        request.realUri = @"/QrCodeList";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_POPULARIZE_ADD]) {
        request.realUri = @"/AddQrCode";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_BET_HISTORY]) {
        request.realUri = @"/user_bet_list";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_POPULARIZE_DELETE]) {
        request.realUri = @"/DeQrCode";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_INFO_UPDATE_AVATAR]) {
        request.realUri = @"/code/Mycenter/upavater";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_DRAWPER]) {
        request.realUri = @"/code/Mycenter/drawper";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_CASHOUT]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:request.params];
        dic[@"draw_money"] =  @([request.params[@"draw_money"] floatValue]*100);
        request.realParams = dic;
        request.realUri = @"/code/Mycenter/draw";
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_EXCAHNGE]) {
        request.realUri = @"/Exchange";
        request.realParams = @{@"money":@([request.params[@"money"] floatValue]*100)};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_WITHDRAW]) {
        request.realUri = @"/Withdraw";
        request.realParams = @{@"money":@([request.params[@"money"] floatValue]*100)};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_SX_BANLANCE]) {
        request.realUri = @"/WebUserBalance";
    }
    if ([request.uri isEqualToString:URI_SMS_SEND]) {
        NSInteger type = [request.params[@"type"] intValue];
        if (type == 0) {
            request.realUri = @"/LoginSend";
        }else{
            request.realUri = @"/DtSend";
        }
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_HELP]) {
        request.realUri = @"/kefu_url";
    }
    return request;
}

/// Called immediately before a request will sent
- (BOOL)canSend:(ABNetRequest *)request {
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_CASHOUT]) {
        return false;
    }
    NSArray *noLoadings = @[URI_ROOM_SEND_GIFT, URI_ACCOUNT_INFO];
    
    if ([noLoadings containsObject:request.uri] == false) {
         [ABUITips showLoading];
    }
//    if ([request.uri isEqualToString:URI_ACCOUNT_HELP]) {
//        return false;
//    }
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
    [ABUITips hideLoading];
    NSDictionary *bank = [Service shared].account.bank;
    NSString *str = @"提现到银行卡(未绑卡)";
    NSString *bankName = bank[@"BankName"];
    NSString *bankCard = [bank stringValueForKey:@"BankCard"];
    if (bankName.length > 0 && bankCard.length > 4) {
        str = [NSString stringWithFormat:@"%@(%@)", bankName, [bankCard substringFromIndex:bankCard.length-4]];
    }
    
    NSArray *paychannels = @[
        @{@"title":str, @"icon":@"yinlian", @"native_id":@"paychannel"}
    ];
    
    NSDictionary *css  = @{
        @"item.size.width":@"100%",
        @"item.size.height":@"60",
    };
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_CASHOUT]) {
        return @{@"css":css, @"items":paychannels};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_RECHARGE_CHANNELS]) {
        NSArray *list = response[@"list"];
        NSArray *pays = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"native_id"] = @"rechargechannel";
            dic[@"title"] = dic[@"pay_aisle"];
            dic[@"xian"] = [NSString stringWithFormat:@"%@-%@", dic[@"min_price"], dic[@"max_price"]];
            return dic;
        }];
        CGFloat w = floor((SCREEN_WIDTH-14)/2);
        NSArray *results =  @[@{
               @"css":@{
                       @"item.size.width":@(w),
                       @"item.size.height":@"68",
                       @"header.size.height":@"44",
                       @"header.size.width":@"100%",
                       @"section.inset.left":@(7),
                       @"section.inset.right":@(7),
               },
               @"header":@{
                          @"title":@"支付方式",
                          @"native_id":@"moneysectionheader"
                      },
               @"items":pays
        }];
        return @{@"list":results};
    }
    
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_RECHARGE]) {
        if ([response isKindOfClass:[NSString class]]) {
            return @{@"url":(NSString *)response};
        }
//        NSArray *numbers = @[@"20", @"30", @"50", @"80", @"100"];
//        NSMutableArray *numberItems = [[NSMutableArray alloc] init];
//        for (int i=0; i<numbers.count; i++) {
//            NSInteger num = [numbers[i] intValue];
//            NSString *dou = [NSString stringWithFormat:@"直播豆%ld", num*2];
//            [numberItems addObject:@{
//                @"number":numbers[i],
//                @"dou":dou,
//                @"native_id":@"moneyitem"
//            }];
//        }
//
//        NSArray *pays = @[
//            @{@"title":@"微信支付", @"icon":@"weixin", @"native_id":@"paychannel", @"count":@(3)},
//            @{@"title":@"支付宝支付", @"icon":@"zhifubao", @"native_id":@"paychannel", @"count":@(3)},
//            @{@"title":@"银行卡支付", @"icon":@"yinlian", @"native_id":@"paychannel", @"count":@(3)}
//        ];
//
//        CGFloat w = floor((SCREEN_WIDTH-14)/3);
//        NSArray *list = @[
//            @{
//                @"css":@{
//                        @"item.size.width":@(w),
//                        @"item.size.height":@"68",
//                        @"header.size.height":@"44",
//                        @"header.size.width":@"100%",
//                        @"section.inset.left":@(7),
//                        @"section.inset.right":@(7),
//                },
//                @"header":@{
//                           @"title":@"充值金额",
//                           @"native_id":@"moneysectionheader"
//                       },
//                @"items":numberItems
//            },
//            @{
//                @"css":@{
//                        @"item.size.width":@"100%",
//                        @"item.size.height":@"60",
//                        @"header.size.height":@"44",
//                        @"header.size.width":@"100%"
//                },
//                @"header":@{
//                           @"title":@"充值方式",
//                           @"native_id":@"moneysectionheader"
//                       },
//                @"items":pays
//            },
//        ];
//        return @{@"list":list};
    }
    
    if ([request.uri isEqualToString:URI_ACCOUNT_CHANGER_LIST]) {
        NSArray *list = response[@"list"];
        list = [ABIteration iterationList:list block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"money"] = [NSString stringWithFormat:@"%.2f", [dic[@"money"] intValue]/100.0];
            dic[@"native_id"] = @"chargeitem";
            return dic;
        }];
        return @{@"list":list};
    }
    
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_LOWERS]) {
        NSArray *list = [ABIteration iterationList:response[@"TeamList"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"last_id"] = response[@"last_id"];
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
        return @{@"list":list, @"count":[response stringValueForKey:@"TeanCount" defaultValue:@"0"], @"is_more":[response stringValueForKey:@"is_more" defaultValue:@"0"]};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_STATIS]) {
        NSArray *titles = @[@"注册人数",@"投注人数",@"投注金额",@"中奖金额",@"充值金额",@"下级返点金额",@"团队返点金额",@"我的返点金额"];
        NSArray *keys = @[@"registerCount",@"betsCount",@"money",@"getMoney",@"recharge",@"feeMoney",@"feeMoney",@"userfeemoney"];
        NSMutableArray *dataList = [[NSMutableArray alloc] init];
        for (int i=0; i<keys.count; i++) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setValue:titles[i] forKey:@"title"];
            [dic setValue:@"statisitem" forKey:@"native_id"];
            
            NSString *content = @"0";
            NSString *title = titles[i];
            if (response[keys[i]]) {
                if ([title containsString:@"人数"]) {
                    content = [NSString stringWithFormat:@"%@人", [response stringValueForKey:keys[i]]];
                }else{
                    content = [NSString stringWithFormat:@"%@元", [response stringValueForKey:keys[i]]];
                }
            }
            [dic setValue:content forKey:@"content"];
            [dataList addObject:dic];
        }
        
        return @{@"list":dataList};
    
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_POPULARIZE_CODELIST]) {
        NSString *extensionimg = response[@"ExtensionImg"];
        NSArray *list = [ABIteration iterationList:response[@"CodeList"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            NSString *extension_url = dic[@"extension_url"];
            if ([extension_url hasPrefix:@"http"] == false) {
                extension_url = [NSString stringWithFormat:@"http://%@", extension_url];
            }
            NSString *atime = [ABTime timestampToTime:[dic stringValueForKey:@"creatime"] format:@"YYYY-MM-dd"];
            NSString *btime = [ABTime timestampToTime:[dic stringValueForKey:@"creatime"] format:@"HH:mm:ss"];
            dic[@"time"] = [NSString stringWithFormat:@"%@\n%@", atime, btime];
            dic[@"qrcode"] = extension_url;
            dic[@"countstr"] = [NSString stringWithFormat:@"%@", dic[@"count"]];
            dic[@"feestr"] = [NSString stringWithFormat:@"%@%%", dic[@"fee"]];
            dic[@"native_id"] = @"popularizecodeitem";
            dic[@"bgimage"] = extensionimg;
//            dic[@"bgimage"] = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597069188352&di=6322bfd9b065aed5a40266bbfcc309bc&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201710%2F22%2F100551dhl5ifua9qotj9k9.png";
            return dic;
        }];
        return @{@"list":list};
    }
    
    if ([request.uri isEqualToString:URI_ACCOUNT_BET_HISTORY]) {
        //status:0等待开牌1结算完成2已取消3作废
        NSDictionary *statusMap = @{@0:@"等待开牌", @1:@"结算完成", @2:@"已取消", @3:@"作废"};
        NSDictionary *rr = @{@"player":@"闲",@"playerPair":@"闲对",
                             @"tie":@"和",@"banker":@"庄",
                             @"bankerPair":@"庄对",@"dragon":@"龙",
                             @"tiger":@"虎"};
        NSMutableDictionary *betMap = [[NSMutableDictionary alloc] initWithDictionary:rr];
        for (int i=1; i<7; i++) {
            NSString *key1 = [NSString stringWithFormat:@"x%i_equal", i];
            NSString *key2 = [NSString stringWithFormat:@"x%i_double", i];
            NSString *key3 = [NSString stringWithFormat:@"x%i_Super_Double", i];
            
            NSString *v1 = [NSString stringWithFormat:@"闲%i平倍", i];
            NSString *v2 = [NSString stringWithFormat:@"闲%i翻倍", i];
            NSString *v3 = [NSString stringWithFormat:@"闲%i超倍", i];
            [betMap setValue:v1 forKey:key1];
            [betMap setValue:v2 forKey:key2];
            [betMap setValue:v3 forKey:key3];
        }
        
        NSArray *arr = @[@"TianMen", @"ShunMen", @"FanMen"];
        NSArray *arrv = @[@"天门", @"顺门", @"反门"];
        for (int i=0; i<3; i++) {
            NSString *key1 = [NSString stringWithFormat:@"%@_equal", arr[i]];
            NSString *key2 = [NSString stringWithFormat:@"%@_double", arr[i]];
            NSString *key3 = [NSString stringWithFormat:@"%@_Super_Double", arr[i]];
            
            NSString *v1 = [NSString stringWithFormat:@"%@平倍", arrv[i]];
            NSString *v2 = [NSString stringWithFormat:@"%@翻倍", arrv[i]];
            NSString *v3 = [NSString stringWithFormat:@"%@超倍", arrv[i]];
            [betMap setValue:v1 forKey:key1];
            [betMap setValue:v2 forKey:key2];
            [betMap setValue:v3 forKey:key3];
        }
        NSDictionary *rResponse = response;
        if ([response isKindOfClass:[NSNull class]]) {
            rResponse = @{@"list":@[]};
        }
        NSArray *list = [ABIteration iterationList:rResponse[@"list"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
            dic[@"date"] = [ABTime timestampToTime:dic[@"creatime"]  format:@"YYYY-MM-dd"];
            dic[@"detail"] = [NSString stringWithFormat:@"%@ %@ %@", [dic stringValueForKey:@"desk_name"], [dic stringValueForKey:@"boot_num"], [dic stringValueForKey:@"pave_num"]];
            dic[@"money"] = [dic stringValueForKey:@""];
            dic[@"time"] = [ABTime timestampToTime:dic[@"creatime"]  format:@"HH:mm:ss"];
            
            NSInteger gm = [dic[@"get_money"] intValue]/100;
            dic[@"gmoney"] = [NSString stringWithFormat:@"%ld", (long)gm];
            dic[@"statusStr"] = statusMap[dic[@"status"]];
            
            NSMutableString *betStr = [[NSMutableString alloc] init];
            NSDictionary *bet_money = dic[@"bet_money"];
            NSArray *allKeys = [bet_money allKeys];
            
            NSInteger ii = 0;
            for (int i=0;i<allKeys.count;i++) {
                NSString *key = allKeys[i];
                NSString *money = [bet_money stringValueForKey:key];
                if ([money intValue] > 0) {
                    NSString *vv = betMap[key];
                    if (ii > 0 && (ii % 2) == 0) {
                        [betStr appendString:@"\n"];
                    }
                    [betStr appendString:[NSString stringWithFormat:@"%@ %i; ", vv, [money intValue]/100]];
                    ii++;
                }
            }
            dic[@"betStr"] = betStr;
            NSInteger rowCount = allKeys.count/2.0;
            if (allKeys.count % 2 != 0) {
                rowCount++;
            }
            
            CGSize size = [betStr sizeWithFont:[UIFont PingFangSC:12] constrainedToSize:CGSizeMake(SCREEN_WIDTH-30-52, MAXFLOAT)];
            dic[@"betStrHeight"] = @(size.height);
            dic[@"item.size.height"] = @(174-20+size.height);
            dic[@"native_id"] = @"gamehistoryitem";
            return dic;
        }];
        return @{@"list":list};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_DRAWPER]) {
        
    }
    
    if ([request.uri isEqualToString:URI_ACCOUNT_BALANCE_INFO]) {
        CGFloat balance = [response[@"info"] intValue]/100.0;
        return @{@"info":[NSString stringWithFormat:@"%.2f", balance]};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_SX_BANLANCE]) {
        CGFloat balance = [response[@"balance"] intValue]/100.0;
        return @{@"balance":[NSString stringWithFormat:@"%.2f", balance]};
    }
    if ([request.uri isEqualToString:URI_ACCOUNT_HELP]) {
        NSString *kefu_url = [response stringValueForKey:@"kefu_url"];
        return @{@"address":kefu_url};
    }
    return response;
}

- (void)didReceiveError:(ABNetRequest *)request error:(ABNetError *)error {
    [ABUITips hideLoading];
    if ([request.uri isEqualToString:URI_ACCOUNT_TEAM_STATIS]) {
        [ABUITips showError:error.message];
    }
}
@end
