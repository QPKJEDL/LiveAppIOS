//
//  Config.m
//  zhibo
//
//  Created by qp on 2020/7/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "Config.h"

@implementation Config
+ (NSArray *)getMe {
    
    NSArray *titleSets = @[
        @[@"团队报表", @"游戏记录", @"游戏规则", @"我看过的"],
        @[@"流水记录", @"充值记录", @"提现记录", @"送出礼物"],
        @[@"帮助与反馈"],
    ];
    
    NSArray *iconSets = @[
        @[@"tuanduibaobiao", @"youxijilu-", @"youxiguiz", @"kanguo"],
        @[@"liushuijilu",@"congzhijilu", @"tixianjil-", @"songchuliwu"],
        @[@"bangzhu"],
    ];
    if ([Service shared].account.shenfen == 1) {
        titleSets = @[
            @[@"团队报表", @"游戏记录", @"游戏规则", @"我看过的"],
            @[@"流水记录", @"充值记录", @"提现记录", @"送出礼物", @"收到礼物"],
            @[@"帮助与反馈"],
        ];
        
        iconSets = @[
            @[@"tuanduibaobiao", @"youxijilu-", @"youxiguiz", @"kanguo"],
            @[@"liushuijilu",@"congzhijilu", @"tixianjil-", @"songchuliwu", @"shoudao"],
            @[@"bangzhu"],
        ];
    }

    NSDictionary *css = @{
        @"item.size.width":@"100%",
        @"item.size.height":@"50",
        @"section.inset.bottom":@"10",
    };
    
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    for (int i=0; i<titleSets.count; i++) {
        NSArray *titles = titleSets[i];
        NSArray *icons = iconSets[i];
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int j=0; j<titles.count; j++) {
            [items addObject:@{
                @"title":titles[j],
                @"icon":icons[j],
                @"native_id":@"arrowitem",
                @"cc":@(true)
            }];
        }
        
        [sections addObject:@{
            @"items":items,
            @"css":css
        }];
    }
    
    return sections;
}

+ (NSArray *)getMeActions {
    return @[
        @{
            @"title":@"充值",
            @"icon":@"congz"
        },
        @{
            @"title":@"提现",
            @"icon":@"tixian"
        },
        @{
            @"title":@"筹码兑换",
            @"icon":@"guanzhu"
        },
        @{
            @"title":@"推广",
            @"icon":@"qianbao"
        }
    ];
}

+ (NSDictionary *)getBank {
    return nil;
}

@end
