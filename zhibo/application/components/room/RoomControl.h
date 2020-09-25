//
//  RoomControl.h
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameStatusPlateView.h"
#import "PokerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface RoomControl : UIView
@property (nonatomic, strong) NSString *shixunPlayAddress;
@property (nonatomic, strong) NSDictionary *roomInfo;
@property (nonatomic, strong) ABUIWebView *wenluWebView;
@property (nonatomic, strong) GameStatusPlateView *plateView;
@property (nonatomic, strong) PokerView *pokerView;
- (void)onReceiveRoomMessage:(NSDictionary *)message;
- (void)onReceivePeerMessage:(NSDictionary *)message;

- (void)receiveRoomInfo:(NSDictionary *)roomInfo;
- (void)receiveWenLu:(NSArray *)list;
- (void)receiveWenLuItem:(NSDictionary *)item;
- (void)refreshRank;

- (void)loadWenLu;

//- (void)onFollow;
- (void)onClose;
- (void)onMore;
- (void)onGift;
//- (void)kickoff;

- (void)liveclose;

- (void)anchorLeave;
- (void)anchorReturn;

- (void)onPlate;

- (void)free;
- (void)edu;

- (void)receiveCards:(NSDictionary *)data gameid:(NSInteger)gameid;
@end

NS_ASSUME_NONNULL_END
