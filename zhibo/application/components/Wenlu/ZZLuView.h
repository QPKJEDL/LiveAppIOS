//
//  ZZLuView.h
//  zhibo
//
//  Created by qp on 2020/8/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZLuView : UIView
@property (nonatomic, strong) NSString *a; //龙，庄
@property (nonatomic, strong) NSString *b; //虎，闲
@property (nonatomic, strong) NSString *c; //和
- (void)push:(NSString *)pie;
@end

NS_ASSUME_NONNULL_END
