//
//  HTTPURI.h
//  zhifu
//
//  Created by qp on 2020/5/20.
//  Copyright © 2020 qp. All rights reserved.
//

#ifndef HTTPURI_h
#define HTTPURI_h

#define ISENABLESSL   1

#define HTTPHost          @"http://192.168.1.6/code"

#define URI_VERSION                         @"/code/Mycenter/version"
#define URI_ACCOUNT_HELP                            @"/account/help"

#define mark ----- index -----
#define URI_INDEX_UPDATE                    @"/index/update"
#define URI_BANNER_LIST                     @"/banner_list"

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
#define URI_ACCOUNT_BIND_CARD             @"/account/bind/card"

#define URI_ACCOUNT_BALANCE_RECHARGE        @"/account/balance/recharge"
#define URI_ACCOUNT_BALANCE_CASHOUT        @"/account/balance/cashout"
#define URI_ACCOUNT_CASHOUT                 @"/account/cashout"
#define URI_ACCOUNT_CHANGER_LIST            @"/account/changer/list"
#define URI_ACCOUNT_RECHARGE_CHANNELS       @"/account/recharge/channels"

#define URI_ROOM_USER_INFO               @"/RoomUserInfo"
#define URI_ACCOUNT_TEAM_LOWERS            @"/account/team/lowers"
#define URI_ACCOUNT_TEAM_STATIS            @"/account/team/statis"
#define URI_ACCOUNT_SX_BANLANCE            @"/account/WebUserBalance"
#define URI_ACCOUNT_EXCAHNGE                @"/account/exchange"
#define URI_ACCOUNT_WITHDRAW                @"/account/withdraw"
#define URI_ACCOUNT_WebUserBetsFee          @"/WebUserBetsFee"
#define URI_ACCOUNT_POPULARIZE_CODELIST     @"/account/popularize/codelist"
#define URI_ACCOUNT_POPULARIZE_ADD     @"/account/popularize/add"
#define URI_ACCOUNT_POPULARIZE_DELETE     @"/account/popularize/delete"
#define URI_ACCOUNT_BET_HISTORY             @"/account/bethistory"

#define URI_ACCOUNT_INFO_UPDATE_AVATAR      @"/account/info/update/avatar"
#define URI_SMS_SEND                        @"/account/DtSend"
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
#define URI_GAME_RESULTS                @"/game/results"
#define URI_GAME_HISTORY                @"/game/history"
#define URI_GAME_RULES                  @"/game/rules"
#define URI_GAME_RESULT_LIST           @"/game/result/list"

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
#define URI_ROOM_SYSTEM                @"/room/system"

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
#define URI_ROOM_GIFTRECORD              @"/room/giftrecord"
#define URI_ACCOUNT_DRAWPER             @"/account/drawper"

#pragma mark -------- user ---------
#define URI_FOLLOW_LIST                         @"/follow/list"
#define URI_FOLLOW_FOLLOW                       @"/follow/follow"
#define URI_FOLLOW_UNFOLLOW                     @"/follow/unfollow"
#define URI_USER_INFO                           @"/user/info"
#define URI_MESSAGE_LIST                        @"/message/list"
#pragma mark ---------- moments --------
#define URI_MOMENTS_LIST                        @"/moments/list"
#define URI_MOMENTS_PUBLISH                     @"/moments/publish"
#define URI_MOMENTS_COMMENTS                     @"/moments/comments"
#define URI_MOMENTS_COMMENT_SEND                     @"/moments/comment/send"
#define URI_MOMENTS_COMMENT_REPLY                     @"/moments/comment/reply"
#define URI_MOMENTS_LIKE                        @"/moments/like"
#define URI_MOMENTS_COMMENT_DELETE              @"/moments/comment/delete"
#define URI_TENCENT_COSSECRET                   @"/code/Mycenter/qr_fornow"
#pragma mark ---------- rank --------
#define URI_RANK_LIST                        @"/rank/list"

#pragma mark ------ shixun -------
#define URI_GAME_LOGIN                   @"/game/login"


#pragma mark ------ channel for mq ------
#define CHANNEL_FOLLOW_CHANGED      @"CHANNEL_FOLLOW_CHANGED" //关注发生变化
#define CHANNEL_COMMENT_CHANGED      @"CHANNEL_COMMENT_CHANGED" //评论发生变化
#define CHANNEL_LIKE_CHANGED      @"CHANNEL_LIKE_CHANGED" //喜欢发生变化
#define CHANNEL_ROOM_GAME          @"CHANNEL_ROOM_GAME" //游戏房间消息
#define CHANNEL_GAME_STATUS          @"CHANNEL_GAME_STATUS" //游戏状态
#define CHANNEL_GAME_RULES          @"CHANNEL_GAME_RULES" //游戏状态
#define CHANNEL_ROOM_INFO          @"CHANNEL_ROOM_INFO" //游戏状态
#define CHANNEL_ROOM_MESSAGE          @"CHANNEL_ROOM_MESSAGE" //游戏状态
#define CHANNEL_ROOM_PEER          @"CHANNEL_ROOM_PEER" //游戏状态
#define CHANNEL_GAME_BALANCE          @"CHANNEL_GAME_BALANCE" //游戏状态
#define CHANNEL_NET_REACHABLE          @"CHANNEL_NET_REACHABLE" //app网络
#define CHANNEL_APP_STATUS          @"CHANNEL_APP_STATUS" //

#define ID_GAME_BAIJIALE      1
#define ID_GAME_LONGHU      2
#define ID_GAME_NIUNIU      3
#define ID_GAME_SANGONG      4
#define ID_GAME_A89      5
#endif /* HTTPURI_h */
