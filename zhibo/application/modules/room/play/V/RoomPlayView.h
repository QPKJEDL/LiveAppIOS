//
//  RoomPlayView.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RoomPlayViewDelegate <NSObject>

- (void)roomPlayViewLoadFail;

@end
@interface RoomPlayView : UIView
@property (nonatomic, weak) id<RoomPlayViewDelegate> delegate;
@property (nonatomic, strong) NSString *abc;
@property (nonatomic, strong) NSString *currentURL;
@property (nonatomic, strong) NSString *erNotice;
- (void)viewWillAppear;

- (void)viewDisAppear;
- (void)free;
- (void)remove;
- (void)pause;
- (void)resume;

- (void)playURL:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
