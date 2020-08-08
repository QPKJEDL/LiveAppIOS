//
//  AppDelegate.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@import TXLiteAVSDK_Smart;
#import "NetProvidor.h"
#import "ABUIListViewMapping.h"
#import "GameDataProcess.h"
#import "AccountDataProcess.h"
#import "RoomDataProcess.h"
#import "FollowDataProcess.h"
#import "NetErrorPlugin.h"
#import <IMService.h>
#import "LoginViewController.h"
#import "UserDataProcess.h"
#import "MessageDataPrecess.h"
#import <WOCrashProtectorManager.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MomentDataProcess.h"
#import "RankDataProcess.h"

#import <QCloudCOSXML/QCloudCOSXML.h>
@interface AppDelegate ()<QCloudSignatureProvider, QCloudCredentailFenceQueueDelegate>
// 一个脚手架实例
@property (nonatomic) QCloudCredentailFenceQueue* credentialFenceQueue;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [WOCrashProtectorManager makeAllEffective];
    [IQKeyboardManager sharedManager].enable = true;
    [IQKeyboardManager sharedManager].enableAutoToolbar = true;
    [self ready];
    
    [self setUpWindow];
    
    [TXLiveBase setLicenceURL:@"http://license.vod2.myqcloud.com/license/v1/91fdbc3ccf9f493cf80ec9410610d562/TXLiveSDK.licence" key:@"cfec6f3245fbc129bdadac94e65c8413"];
    
    QCloudServiceConfiguration* configuration = [QCloudServiceConfiguration new];
    QCloudCOSXMLEndPoint* endpoint = [[QCloudCOSXMLEndPoint alloc] init];
    // 服务地域简称，例如广州地区是 ap-guangzhou
    endpoint.regionName = @"ap-guangzhou";
    // 使用 HTTPS
    endpoint.useHTTPS = true;
    configuration.endpoint = endpoint;
    // 密钥提供者为自己
    configuration.signatureProvider = self;
    // 初始化 COS 服务示例
    [QCloudCOSXMLService registerDefaultCOSXMLWithConfiguration:configuration];
    [QCloudCOSTransferMangerService registerDefaultCOSTransferMangerWithConfiguration:
        configuration];

    // 初始化临时密钥脚手架
    self.credentialFenceQueue = [QCloudCredentailFenceQueue new];
    self.credentialFenceQueue.delegate = self;
    
    return YES;
}

- (void) fenceQueue:(QCloudCredentailFenceQueue * )queue requestCreatorWithContinue:(QCloudCredentailFenceQueueContinue)continueBlock
{
    //这里同步从后台服务器获取临时密钥
    //...

    QCloudCredential* credential = [QCloudCredential new];
    // 临时密钥 SecretId
    credential.secretID = @"COS_SECRETID";
    // 临时密钥 SecretKey
    credential.secretKey = @"COS_SECRETKEY";
    // 临时密钥 Token
    credential.token = @"COS_TOKEN";
    // 强烈建议返回服务器时间作为签名的开始时间
    // 用来避免由于用户手机本地时间偏差过大导致的签名不正确
    credential.startDate = [[[NSDateFormatter alloc] init]
        dateFromString:@"startTime"]; // 单位是秒
    credential.experationDate = [[[NSDateFormatter alloc] init]
        dateFromString:@"expiredTime"];

    QCloudAuthentationV5Creator* creator = [[QCloudAuthentationV5Creator alloc]
        initWithCredential:credential];
    continueBlock(creator, nil);
}

// 获取签名的方法入口，这里演示了获取临时密钥并计算签名的过程
// 您也可以自定义计算签名的过程
- (void) signatureWithFields:(QCloudSignatureFields*)fileds
                     request:(QCloudBizHTTPRequest*)request
                  urlRequest:(NSMutableURLRequest*)urlRequst
                   compelete:(QCloudHTTPAuthentationContinueBlock)continueBlock
{
    [self.credentialFenceQueue performAction:^(QCloudAuthentationCreator *creator,
        NSError *error) {
        if (error) {
            continueBlock(nil, error);
        } else {
            QCloudSignature* signature =  [creator signatureForData:urlRequst];
            continueBlock(signature, nil);
        }
    }];
}

//init window and display
- (void)setUpWindow {
    if ([Service shared].account.isLogin) {
        CGRect winFrame = [[UIScreen mainScreen] bounds];
        self.window = [[UIWindow alloc] initWithFrame:winFrame];
        self.window.rootViewController = [[MainViewController alloc] init];
        [self.window makeKeyAndVisible];
    }else{
        CGRect winFrame = [[UIScreen mainScreen] bounds];
        self.window = [[UIWindow alloc] initWithFrame:winFrame];
        self.window.rootViewController = [[LoginViewController alloc] init];
        [self.window makeKeyAndVisible];
    }
    
}

- (void)ready {
    NetProvidor *p = [[NetProvidor alloc] init];
    
    [ABNetConfiguration shared].provider = p;
    [ABUIListViewMapping shared].mapping = [[NSMutableDictionary alloc] initWithDictionary:@{
        @"anchoritem":@"AnchorItemView",
        @"betoption":@"BetOptionView",
        @"livecomment":@"LiveCommentItemView",
        @"topic":@"TopicItemView",
        @"channel":@"ChannelItemView",
        @"giftitem":@"GiftItemView",
        @"titleimage":@"TitleImageItemView",
        @"titleimage2":@"TitleImage2ItemView",
        @"user":@"UserItemView",
        @"message":@"MessageItemView",
        @"notice":@"NoticeItemView",
        @"usersub":@"UserSubItemView",
        @"deskitem":@"DeskItemView",
        @"giftrankitem":@"GiftRankItemView",
        @"roomaudience":@"RoomAudienceItemView",
        @"roommesagewelcome":@"RoomMessageWelcomeItemView",
        @"manageritem":@"ManagerItemView",
        @"gameresultitem":@"GameResultItemView",
        @"userpromptaction":@"UserPromptActionItemView",
        @"gifthistory":@"GiftHistoryItemView",
        @"paychannel":@"PayChannelItemView",
        @"moneyitem":@"MoneyItemView",
        @"moneysectionheader":@"MoneySectionHeaderView",
        @"arrowitem":@"ArrowItemView",
        @"inputitem":@"InputItemView",
        @"switchitem":@"SwitchItemView",
        @"momentitem":@"MomentItemView",
        @"imageitem":@"ImageItemView",
        @"rankitem":@"RankItemView",
        @"gamehistoryitem":@"GameHistoryItemView",
        @"gameruleitem":@"GameRuleItemView",
        @"commentitem":@"CommentItemView",
        @"commentitemreply":@"CommentReplyItemView",
        @"chargeitem":@"ChargeHistoryItemView",
        @"loweritem":@"TeamLowerItemView",
        @"statisitem":@"TeamStatisItemView",
        @"popularizecodeitem":@"PopularizeCodeItemView"
    }];
    
    [ABNet shared].errorHandle = [[NetErrorPlugin alloc] init];
    [[ABNet shared] registerDataProcess:[[RoomDataProcess alloc] init] key:@"/room"];
    [[ABNet shared] registerDataProcess:[[GameDataProcess alloc] init] key:@"/game"];
    [[ABNet shared] registerDataProcess:[[AccountDataProcess alloc] init] key:@"/account"];
    [[ABNet shared] registerDataProcess:[[FollowDataProcess alloc] init] key:@"/follow"];
    [[ABNet shared] registerDataProcess:[[UserDataProcess alloc] init] key:@"/user"];
    [[ABNet shared] registerDataProcess:[[MessageDataPrecess alloc] init] key:@"/message"];
    [[ABNet shared] registerDataProcess:[[MomentDataProcess alloc] init] key:@"/moments"];
    [[ABNet shared] registerDataProcess:[[RankDataProcess alloc] init] key:@"/rank"];
    
    [[Service shared] refreshGameURL];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[Service shared] enterBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[RoomContext shared].playControl refreshRank];
    [[RoomContext shared].pushControl refreshRank];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//    [[IMService instance] enterBackground];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[IMService instance] enterForeground];
}
@end

//QCloudCOSXMLUploadObjectRequest* put = [QCloudCOSXMLUploadObjectRequest new];
//// 本地文件路径
//NSURL* url = [NSURL fileURLWithPath:@"文件的URL"];
//// 存储桶名称，格式为 BucketName-APPID
//put.bucket = @"examplebucket-1250000000";
//// 对象键，是对象在 COS 上的完整路径，如果带目录的话，格式为 "dir1/object1"
//put.object = @"exampleobject";
////需要上传的对象内容。可以传入NSData*或者NSURL*类型的变量
//put.body =  url;
////监听上传进度
//[put setSendProcessBlock:^(int64_t bytesSent,
//                            int64_t totalBytesSent,
//                            int64_t totalBytesExpectedToSend) {
//    //      bytesSent                   新增字节数
//    //      totalBytesSent              本次上传的总字节数
//    //      totalBytesExpectedToSend    本地上传的目标字节数
//}];
//
////监听上传结果
//[put setFinishBlock:^(id outputObject, NSError *error) {
//    //可以从 outputObject 中获取 response 中 etag 或者自定义头部等信息
//    NSDictionary * result = (NSDictionary *)outputObject;
//}];
//
//[[QCloudCOSTransferMangerService defaultCOSTransferManager] UploadObject:put];
