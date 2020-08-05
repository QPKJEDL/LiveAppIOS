//
//  HTAsyncSocket.h
//  zhibo
//
//  Created by qp on 2020/7/31.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GCDAsyncSocket.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^recive_Success_Block)(NSString *data,NSString *type);
 
@interface HTAsyncSocket : NSObject
 
//sockct
@property(nonatomic,strong)GCDAsyncSocket* socket;
 
//链接服务器
- (BOOL)connecteServerWith:(NSString *)host onPort:(uint16_t )port;
 
//断开服务器
+ (void)disconnect;
 
//发送数据
- (void)sendDataWithType:(int)type withDic:(NSMutableDictionary *)dic ;
 
//回调数据
- (void) reciveData:(recive_Success_Block)reciveBlock;
 
 
//拆包的到lenght
+ (NSInteger)unpackingLenght:(NSString *) packing;
 
//拆包的到type
+ (NSString *)unpackingHeard:(NSString *)packing;
 
//拆包的到json
+ (NSDictionary *)unpackingDicWith:(NSString *) packing;
 
//拆包的到NSMutableArray
+ (NSMutableArray *) unpackingArrWith:(NSString *)packing WithHeard:(NSString *)str;
 
//单利
+(instancetype) shareAsncSocket;
@end

NS_ASSUME_NONNULL_END
