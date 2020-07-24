//
//  GameDataHelper.m
//  zhibo
//
//  Created by qp on 2020/6/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameDataHelper.h"

@interface GameDataHelper ()
@property (nonatomic, strong) NSDictionary *gameconfigs;
@end
@implementation GameDataHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gameconfigs = [ABFileManager readDicWithJSONFile:@"betrules"][@"data"];
    }
    return self;
}

- (NSDictionary *)getGameBetRuleWithParams:(NSDictionary *)params {
    NSString *gid = params[@"game_id"];
    NSDictionary *fee = params[@"fee"];
    
    NSString *minlimit = params[@"minlimit"];
    NSString *maxlimit = params[@"maxlimit"];
    
//    BOOL issuper = [params[@"issuper"] boolValue];
    
    NSArray *coins = [self _getCoins:@[@"10", @"20", @"50",@"100",@"200",@"500",@"1000", @"5000", @"10000", @"50000"]];
    NSString *gidstr = [NSString stringWithFormat:@"%@", gid];
    NSDictionary *config = self.gameconfigs[gidstr];
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithDictionary:config];
    NSArray *options = config[@"options"];
    
    if (options == nil) {
        //add
        int xian = [config[@"xian"] intValue];
        options = [self _getXians:xian deep:3 fee:fee];
    }
    
    NSMutableArray *nOptions = [[NSMutableArray alloc] init];
    for (int i=0;i<options.count;i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:options[i]];
//        dic[@"css"] = [self _getCss:[self _getModule:gidstr] index:i];
        if (fee[@"Double"] != nil) {

        }else{
            CGFloat odd = [fee[dic[@"id"]] integerValue]/100.0;
            dic[@"odd"] = [NSString stringWithFormat:@"1翻%.2f", odd];
        }
        dic[@"native_id"] = @"betoption";
        [nOptions addObject:dic];
    }
    result[@"options"] = nOptions;
    result[@"coins"] = coins;
    result[@"tip"] = [NSString stringWithFormat:@"限红\n%@-%@", minlimit, maxlimit];
    return result;
}

- (NSArray *)_getCoins:(NSArray<NSString *> *)nums {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (NSString *str in nums) {
        NSString *icon = [NSString stringWithFormat:@"coin%@", str];
        [list addObject:@{@"icon":icon, @"num":str}];
    }
    return list;
}

- (NSDictionary *)getGameBetResultWithParams:(NSDictionary *)params {
    NSString *gid = params[@"game_id"];
    NSString *gidstr = [NSString stringWithFormat:@"%@", gid];
    NSDictionary *config = self.gameconfigs[gidstr];
    NSArray *options = config[@"options"];
    if ([gid intValue] == 5) {
        options = config[@"rr"];
    }
    
    if (options == nil) {
        //add
        int xian = [config[@"xian"] intValue];
        options = [self _getXians:xian];
    }
    
    NSMutableArray *rr = [[NSMutableArray alloc] init];
    for (int i=0;i<options.count;i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:options[i]];
        [rr addObject:@{
            @"title":dic[@"title"],
            @"r":dic[@"r"]
        }];
    }
    return @{@"list":rr};
}

- (NSArray *)_getXians:(NSInteger)num {
    NSMutableArray *options = [[NSMutableArray alloc] init];
    [options addObject:@{
        @"title":@"庄",
        @"r":@"win",
    }];
    for (int i=0; i<num; i++) {
        NSString *title = [NSString stringWithFormat:@"闲%d", i+1];
        NSString *r = [NSString stringWithFormat:@"x%dwin", i+1];
        [options addObject:@{
            @"title":title,
            @"r":r,
        }];
    }

    return options;
}

- (NSArray *)_getXians:(NSInteger)num deep:(NSInteger)deep fee:(NSDictionary *)fee {
    
    NSArray *aa = @[@"", @"翻倍", @"超倍"];
    NSArray *bb = @[@"equal", @"double", @"SuperDouble"];
    
    NSArray *cc = @[@"Equal", @"Double", @"SuperDouble"];
    NSMutableDictionary *css = [[NSMutableDictionary alloc] initWithDictionary:@{@"w":@"33%",@"h":@"50%",@"title.color":@"#F72EFF",@"title.font":@"15"}];
    if (deep == 2) {
        css[@"w"] = @"50%";
    }
    NSMutableArray *options = [[NSMutableArray alloc] init];
    for (int i=0; i<num; i++) {
        NSString *title = [NSString stringWithFormat:@"闲%d", i+1];
        NSString *key = [NSString stringWithFormat:@"x%d", i+1];
        for (int j=0; j<deep; j++) {
            [options addObject:@{
                @"odd":[NSString stringWithFormat:@"1翻%.2f", [fee[cc[j]] integerValue]/100.0],
                @"title":[NSString stringWithFormat:@"%@%@", title, aa[j]],
                @"id":[NSString stringWithFormat:@"%@_%@", key, bb[j]],
                @"css":css
            }];
        }
    }
    
    return options;
}

- (NSDictionary *)_getCss:(NSString *)module index:(NSInteger)index {
    NSString *w = @"33%";
    NSString *h = @"50%";
    NSString *tf = @"22";
    if ([module isEqualToString:@"3x1"]) {
        w = @"33%";
        h = @"100%";
    }
    if ([module isEqualToString:@"2xn"]) {
        w = @"50%";
        h = @"50%";
        tf = @"15";
    }
    
    if ([module isEqualToString:@"3xn"]) {
        w = @"33%";
        h = @"50%";
        tf = @"15";
    }

    return @{@"w":w,@"h":h,@"title.color":@"#F72EFF",@"title.font":tf};
}

//- (NSDictionary *)
@end
