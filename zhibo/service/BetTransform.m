//
//  BetTransform.m
//  zhibo
//
//  Created by qp on 2020/8/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BetTransform.h"
@interface BetTransform ()
@property (nonatomic, strong) NSDictionary *gameconfigs;
@property (nonatomic, strong) NSDictionary *betKeyMap;
@property (nonatomic, strong) NSDictionary *musicBetKeyMap;
@end
@implementation BetTransform
+ (RoomPrompt *)shared {
    static RoomPrompt *instance = nil;
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
        self.gameconfigs = [ABFileManager readDicWithJSONFile:@"betrules"][@"data"];
        self.betKeyMap = @{
            @"1_1":@"和局",
            @"1_5":@"闲对",
            @"1_2":@"庄对",
            @"1_4":@"闲赢",
            @"1_7":@"庄赢",
            @"2_1":@"和",
            @"2_4":@"虎赢",
            @"2_7":@"龙赢",
            @"win":@"庄赢",
            @"x1win":@"闲1赢",
            @"x2win":@"闲2赢",
            @"x3win":@"闲3赢",
            @"x4win":@"闲4赢",
            @"x5win":@"闲5赢",
            @"x6win":@"闲6赢",
            @"Bankerwin":@"庄赢",
            @"ShunMenwin":@"顺门赢",
            @"TianMenwin":@"天门赢",
            @"FanMenwin":@"反门赢",
            
        };
        self.musicBetKeyMap = @{
            @"1_1":@"heJu.mp3",
            @"1_5":@"xianPair.mp3",
            @"1_2":@"bankPair.mp3",
            @"1_4":@"xianWin.mp3",
            @"1_7":@"bankWin.mp3",
            @"2_1":@"heJu.mp3",
            @"2_4":@"huWin.mp3",
            @"2_7":@"longWin.mp3",
            @"win":@"bankWin.mp3",
            @"x1win":@"xian1.mp3",
            @"x2win":@"xian2.mp3",
            @"x3win":@"xian3.mp3",
            @"x4win":@"xian4.mp3",
            @"x5win":@"xian5.mp3",
            @"x6win":@"xian6.mp3",
            @"Bankerwin":@"bankWin.mp3",
            @"ShunMenwin":@"shunMen.mp3",
            @"TianMenwin":@"tianMen.mp3",
            @"FanMenwin":@"fanMen.mp3",
        };
    }
    return self;
}

- (NSString *)getBetDescriptionGid:(NSInteger)gid winner:(nonnull id)winner {
    
    NSString *winKey = [NSString stringWithFormat:@"%@", winner];
    if ([winKey containsString:@"{"] && [winKey containsString:@"}"]) {
        NSDictionary *dic = [winKey toDictionary];
        winKey = [[dic allValues] componentsJoinedByString:@","];
    }
    
    NSArray *winKeys = [winKey componentsSeparatedByString:@","];
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSString *key in winKeys) {
        NSString *one = @"";
        if (gid == 1 || gid == 2) {
            NSString *x = [NSString stringWithFormat:@"%li_%@", (long)gid, key];
            one = self.betKeyMap[x];
        }else{
           one = self.betKeyMap[key];
        }
        if (one) {
            [str appendString:one];
        }
    }
    return str;
}


- (NSString *)getMusicGid:(NSInteger)gid winner:(id)winner {
    NSString *winKey = [NSString stringWithFormat:@"%@", winner];
    if ([winKey containsString:@"{"] && [winKey containsString:@"}"]) {
        NSDictionary *dic = [winKey toDictionary];
        winKey = [[dic allValues] componentsJoinedByString:@","];
    }
    
    NSArray *winKeys = [winKey componentsSeparatedByString:@","];
    NSMutableString *str = [[NSMutableString alloc] init];
    int i = 0;
    for (NSString *key in winKeys) {
        NSString *one = @"";
        if (gid == 1 || gid == 2) {
            NSString *x = [NSString stringWithFormat:@"%li_%@", (long)gid, key];
            one = self.musicBetKeyMap[x];
        }else{
           one = self.musicBetKeyMap[key];
        }
        if (one) {
            [str appendString:one];
            if (i < winKeys.count-1) {
               [str appendString:@","];
            }
            
        }
        i++;
    }
    
    return str;
}

@end
