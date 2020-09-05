//
//  NSRouter.h
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSRouter : NSObject
+ (void)doLogin;
+ (void)gotoRoomPlayPage:(NSInteger)roomId;
+ (void)gotoZhiBoPage;
+ (void)gotoPublishDT;
+ (void)gotoMessagePage:(NSInteger)tag;
+ (void)gotoSearch;
+ (void)gotoProfile:(NSInteger)uid;
+ (void)gotoWallet;
+ (void)gotoCashOut;
+ (void)gotoReCharge;
+ (void)gotoChatPage;
+ (void)gotoSettingPage:(NSString *)key;
+ (void)gotoFootPrint;
+ (void)gotoBill;
+ (void)gotoUserList:(NSString *)title;
+ (void)gotoKaibo;
+ (void)dismiss;
+ (void)back;

+ (void)gotoGiftHistroy:(NSInteger)type;

+ (void)showImages;
+ (void)gotoGameHistroy;
+ (void)gotoGameRules;
+ (void)gotoWeb:(NSString *)path title:(NSString *)title;

+ (void)gotoChargerHistory:(NSInteger)type;
+ (void)gotoTeamForm;
+ (void)gotoPopularize;
+ (void)gotoTransform;
+ (void)gotoPopularizeList;

+ (void)gotoHelp;
+ (void)gotoXXXX;
@end

NS_ASSUME_NONNULL_END
