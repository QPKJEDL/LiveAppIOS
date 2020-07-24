//
//  HTTPURI.h
//  zhifu
//
//  Created by qp on 2020/5/20.
//  Copyright © 2020 qp. All rights reserved.
//

#ifndef HTTPURI_h
#define HTTPURI_h


#define HTTPHost          @"http://192.168.1.6/code"

#define mark ----- index -----
#define URI_INDEX_UPDATE                    @"/index/update"


#pragma mark ----- account --------
#define URI_ACCOUNT_LOGIN                   @"/account/login"
#define URI_ACCOUNT_LOGIN_SENDCODE          @"/account/login/sendcode"
#define URI_ACCOUNT_INFO                    @"/account/info"
#define URI_ACCOUNT_BALANCE_INFO            @"/account/getaccount"

#define URI_ACCOUNT_REGISTER                @"/account/register"
#define URI_ACCOUNT_FORGET_LOGIN            @"/account/forget/login"
#define URI_ACCOUNT_FORGET_RECHARGE         @"/account/forget/recharge"
#define URI_ACCOUNT_EDIT_NICKNAME           @"/account/edit/nickname"
#define URI_ACCOUNT_BIND_WECHAT             @"/account/bind/wechat"
#define URI_ACCOUNT_BIND_ALIPAY             @"/account/bind/alipay"

#define URI_ACCOUNT_BALANCE_RECHARGE        @"/account/balance/recharge"
#define URI_ACCOUNT_BALANCE_CASHOUT        @"/account/balance/cashout"

#define URI_ROOM_USER_INFO               @"/RoomUserInfo"
#pragma mark ------ zfnotice -------
#define URI_ZFNOTICE_KEFU                   @"/zfnotice/kefu"


#pragma mark ------- game -----------
#define URI_GAME_LIST                   @"/game/list"
#define URI_GAME_BET                    @"/game/bet"
#define URI_GAME_UNBET                  @"/game/unbet"
#define URI_GAME_BET_RULES              @"/game/bet/rules"
#define URI_GAME_BET_FEE                @"/game/bet/fee"
#define URI_GAME_DESK                   @"/game/desk"
#define URI_GAME_DESKLIST               @"/game/desklist"
#define URI_GAME_RESULTS               @"/game/results"
#pragma mark --------- channel ---------
#define URI_CHANNEL_LIST                @"/GetHasChannel"
#define URI_LABEL_LIST                  @"/GetLabel"

#pragma mark ------- room -----------
#define URI_ROOM_LIST                    @"/room/list"
#define URI_ROOM_INFO                     @"/room/info"
#define URI_ROOM_GIFT                     @"/room/gift"
#define URI_ROOM_SETCOVER                @"/room/setcover"
#define URI_ROOM_SETGAME                @"/room/setgame"
#define URI_ROOM_CLOSE                @"/room/close"
#define URI_ROOM_LABELS                @"/room/labels"
#define URI_ROOM_CHANNEL                @"/room/channel"

#define URI_ROOM_GAME                   @"/room/game"
#define URI_LIVE_COMMENT_LIST           @"/live/comment/list"
#define URI_ROOM_MANAGER                @"/room/manager"
#define URI_ROOM_SETMANAGER             @"/room/setmanager"
#define URI_ROOM_RMMANAGER              @"/room/rmmanager"
#define URI_ROOM_BANSTATUS              @"/room/banstatus"
#define URI_ROOM_BAN                    @"/room/ban"
#define URI_ROOM_UNBAN                  @"/room/unban"
#define URI_ROOM_GIFTRANK               @"/room/giftrank"
#define URI_ROOM_KICK                   @"/room/kick"
#define URI_ROOM_SEND_GIFT              @"/room/sendgift"
#define URI_ROOM_MANAGERLIST                   @"/room/managerlist"
#define URI_ROOM_LEAVE                  @"/LiveLeaveRoom"
#define URI_ROOM_RETURN                  @"/LiveReturnRoom"

#pragma mark -------- user ---------
#define URI_FOLLOW_LIST                         @"/follow/list"
#define URI_FOLLOW_FOLLOW                       @"/follow/follow"
#define URI_FOLLOW_UNFOLLOW                     @"/follow/unfollow"
#define URI_USER_INFO                           @"/user/info"
#define URI_MESSAGE_LIST                        @"/message/list"

#pragma mark ------ shixun -------
#define URI_GAME_LOGIN                   @"/game/login"

#endif /* HTTPURI_h */
