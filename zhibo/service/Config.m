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
        @[@"我看过的", @"用户等级", @"直播帐户", @"会员特权", @"活动中心"],
        @[@"主播相关", @"粉丝礼物"],
        @[@"帮助与反馈"],
    ];
    
    NSArray *iconSets = @[
        @[@"kanguo", @"yonghudengji", @"zhibozhenghu", @"zhan", @"huodongzhongxin"],
        @[@"zhiboxiangguan", @"fensiliwu"],
        @[@"bangzhu"],
    ];
    
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
            @"title":@"私信",
            @"icon":@"shixin"
        },
        @{
            @"title":@"任务",
            @"icon":@"renwu"
        },
        @{
            @"title":@"钱包",
            @"icon":@"qianbao"
        },
        @{
            @"title":@"等级",
            @"icon":@"dengji"
        }
    ];
}

@end
