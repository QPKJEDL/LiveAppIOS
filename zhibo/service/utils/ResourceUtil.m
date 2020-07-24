//
//  ResourceUtil.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ResourceUtil.h"

@implementation ResourceUtil

//+(Singleton *) shareInstance{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc]init];
//    });
//    return instance;
//}

+ (NSDictionary *)readDataWithFileName:(NSString *)name {
    @try {
        NSString *path = [NSBundle.mainBundle pathForResource:name ofType:@"json"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        return dic;
    }
    @catch (NSException *exception) {
        NSLog(@"@NSException");
        NSLog(@"%@", exception);
    }
    @finally {
        NSLog(@"@finally");
    }
}

+ (NSDictionary *)tabData {
    return [ResourceUtil readDataWithFileName:@"tabbar"];
}

+ (NSDictionary *)popupData {
    return [ResourceUtil readDataWithFileName:@"popup"];
}

+ (NSDictionary *)momentData {
    return [ResourceUtil readDataWithFileName:@"momentlist"];
}
@end
