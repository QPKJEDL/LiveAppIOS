//
//  MineTopView.h
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserItem.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MineTopViewDelegate <NSObject>



@end

@interface MineTopView : UIView
- (void)loadData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
