//
//  PublicHeader.h
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h

#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "UI.h"
#import "Config.h"
#import "RoomPrompt.h"
#pragma mark utils ifneed
#import "ResourceUtil.h"
#import "DeviceUtil.h"
#import "TimeUtil.h"
#import "ViewUtil.h"

#pragma mark router
#import "NSRouter.h"

#import "RoomStack.h"
#import <JXCategoryView/JXCategoryView.h>
#import <SDWebImage/SDWebImage.h>


typedef enum : NSUInteger {
    GameTypeBJL = 1,
    GameTypeLH,
    GameTypeNN,
    GameTypeSG,
    GameTypeA89
} GameType;

#endif /* PublicHeader_h */
