//
//  RoomPlayView.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomPlayView : UIView
- (void)viewWillAppear;

- (void)viewDisAppear;
- (void)free;
- (void)remove;

- (void)playURL:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
