//
//  Dao.m
//  zhibo
//
//  Created by qp on 2020/6/21.
//  Copyright © 2020 qp. All rights reserved.
//

#import "Dao.h"
@interface Dao ()
@property (nonatomic, strong) NSMutableDictionary *dic;
@end
@implementation Dao
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dic = [[NSMutableDictionary alloc] init];
        self.fileName = @"data";
    }
    return self;
}

- (void)load {
    NSString *filePath = [self _filePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
}

- (NSString *)_filePath {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsPath, self.fileName];
    return filePath;
}

- (void)save {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.dic options:NSJSONWritingPrettyPrinted error:nil];
    if ([data writeToFile:[self _filePath] atomically:true]) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败");
    }
}

- (void)set:(nullable id)value key:(NSString *)key {
    [self.dic setValue:value forKey:key];
}

- (id)get:(NSString *)key {
    return [self.dic objectForKey:key];
}

- (BOOL)del:(NSString *)key {
    [self.dic removeObjectForKey:key];
    return true;
}

@end
