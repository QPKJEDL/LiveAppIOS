//
//  Dao.h
//  zhibo
//
//  Created by qp on 2020/6/21.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dao : NSObject
@property (nonatomic, strong) NSString *fileName;
- (void)set:(nullable id)value key:(NSString *)key;
- (id)get:(NSString *)key;
- (BOOL)del:(NSString *)key;

- (void)load;
- (void)save;
@end

NS_ASSUME_NONNULL_END
