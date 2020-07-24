//
//  SettingPresent.m
//  zhibo
//
//  Created by FaiWong on 2020/4/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import "SettingPresent.h"

@implementation SettingPresent
//- (void)getSettingData:(NSString *)key {
//    NSDictionary *data = [ResourceUtil readDataWithFileName:@"setting2"][key];
//    self.title = data[@"title"];
//    self.actions = data[@"actions"];
//    NSArray *dataList = data[@"sections"];
//    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
//    for (NSDictionary *tmpItemSection in dataList) {
//        NSMutableArray *sectionList = [[NSMutableArray alloc] init];
//        NSArray *list = tmpItemSection[@"rows"];
//        for (NSDictionary *ii in list) {
//            NSMutableDictionary *newII = [[NSMutableDictionary alloc] initWithDictionary:ii];
//            [sectionList addObject:newII];
//        }
//        [tmpList addObject:sectionList];
//    }
//    self.settingSections = tmpList;
//
//}
- (void)getSettingData:(NSString *)key {
    NSDictionary *data = [ABFileManager readDicWithJSONFile:@"setting2"][key];
    NSArray *datalist = data[@"sections"];
    self.title = data[@"title"];
    self.actions = data[@"actions"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(present:onDataList:)]) {
        [self.delegate present:self onDataList:datalist];
    }
//    self.title = data[@"title"];
//    self.actions = data[@"actions"];
//    NSArray *dataList = data[@"sections"];
//    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
//    for (NSDictionary *tmpItemSection in dataList) {
//        NSMutableArray *sectionList = [[NSMutableArray alloc] init];
//        NSArray *list = tmpItemSection[@"rows"];
//        for (NSDictionary *ii in list) {
//            NSMutableDictionary *newII = [[NSMutableDictionary alloc] initWithDictionary:ii];
//            [sectionList addObject:newII];
//        }
//        [tmpList addObject:sectionList];
//    }
//    self.settingSections = tmpList;

}
@end
