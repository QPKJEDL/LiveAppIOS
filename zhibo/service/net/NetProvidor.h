//
//  NetProvidor.h
//  zhibo
//
//  Created by qp on 2020/6/17.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ABNetConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetProvidor : ABNetConfigurationProvider
@property (nonatomic, strong) NSString *imHost;
@end

NS_ASSUME_NONNULL_END
