//
//  HTAsyncSocket.m
//  zhibo
//
//  Created by qp on 2020/7/31.
//  Copyright © 2020 qp. All rights reserved.
//

#import "HTAsyncSocket.h"

@interface HTAsyncSocket()<GCDAsyncSocketDelegate>
//定时器
@property(nonatomic,strong)NSTimer* connectTimer;
 
//接收成功的回调
@property(nonatomic,copy) recive_Success_Block reciveBlock;
 
//接收完整的包
@property(nonatomic,strong)NSMutableData* completeData;
 
//完整包的长度
@property(nonatomic,assign)NSInteger lenght;
 
//发送心跳包的线程
@property (nonatomic, strong)NSThread *thread;
 
@end
 
@implementation HTAsyncSocket
 
//链接服务器
- (BOOL) connecteServerWith:(NSString *)host  onPort:(uint16_t)port{
    static BOOL success;
    GCDAsyncSocket *sockte =  [HTAsyncSocket shareAsncSocket].socket;
    if (!sockte.isConnected) {
        NSError *err;
        success = [sockte connectToHost:host onPort:port error:&err];
        if (err != nil)
        {
            NSLog(@"%@",err);
        }
    }
    return success;
}
 
//链接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"交易链接成功");
 
    [_socket readDataWithTimeout:-1 tag:0];
    
    //开始发送心跳包
    [self.thread start];
}
 
 
//心跳包发送
- (void)threadStart{
    @autoreleasepool {
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(heartBeat) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]run];
    }
}
 
- (void)heartBeat{
    NSString *str = @"心跳包内容";
    NSData *ndata = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:ndata withTimeout:-1 tag:1];
}
 
//socket断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
    NSLog(@"交易服务器断开%@",err);
}
 
 
//断开服务器
+ (void)disconnect{
    //断开连接时候一定要清空socket
    GCDAsyncSocket *sockte =  [HTAsyncSocket shareAsncSocket].socket;
    
    [sockte disconnect];
    
    sockte = nil;
}
 
//接收信息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    [self.completeData appendData:data];
    NSString *msg = [[NSString alloc] initWithData:self.completeData encoding:NSUTF8StringEncoding];
    self.lenght = [HTAsyncSocket unpackingLenght:msg];
    //这里因为有时候会粘包，所以等长度一致，拼接完整之后再发送数据出去
//    NSLog(@"self.completeData.length-%ld  self.lenght-%ld",self.completeData.length ,self.lenght);
    if (self.completeData.length >= self.lenght) {
        NSString *type = [HTAsyncSocket unpackingHeard:msg];
        if (_reciveBlock ) {
//            NSLog(@"tmsg = %@ ", msg);
            _reciveBlock(msg,type);
        }
        self.completeData = 0;
        self.lenght = 0;
    }
    [self.socket readDataWithTimeout: -1 tag:0];
}
 
//发送数据
- (void)sendDataWithType:(int)type withDic:(NSMutableDictionary *)dic {
    NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *lenght = [NSString stringWithFormat:@"%ld",json.length];
    int num = [lenght intValue]+37;
    
    lenght = [self num:num];
    NSString *stype = [self num:type];
 
    NSString *header= [NSString stringWithFormat:@"V0.1%@%@00000000000000000",lenght,stype];
    NSString *package = [NSString stringWithFormat:@"%@%@",header,json];
    NSLog(@"package-%@",package);
    NSData *ndata = [package dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.socket writeData:ndata withTimeout:-1 tag:1];
    
}
 
//接收数据
- (void) reciveData:(recive_Success_Block)reciveBlock {
   _reciveBlock = reciveBlock;
}
 
- (NSString *)num:(int) num{
    NSString *str = [NSString stringWithFormat:@"%d",num];
    int sum = 0 ;
    while(num!=0){
        num /= 10;
        sum++;
    }
    for (int i = sum ; i < 8 ; i ++) {
        str = [NSString stringWithFormat:@"0%@",str];
    }
    return str;
}
 
 
//拆分出长度
+ (NSInteger)unpackingLenght:(NSString *) packing{
    if (!packing ) return 0;
    NSRange range =  NSMakeRange (0, 37);
    NSString *heard = [packing substringWithRange:range];
    
    NSRange sRange = NSMakeRange(4, 8);
    NSString *lenght = [heard substringWithRange:sRange];
    
    NSInteger slenght = [lenght integerValue];
    return slenght;
}
 
//拆分出类型
+ (NSString *)unpackingHeard:(NSString *)packing{
    if (!packing ) return nil;
    NSRange range =  NSMakeRange (0, 37);
    NSString *heard = [packing substringWithRange:range];
    
    NSRange sRange = NSMakeRange(12, 8);
    NSString *type = [heard substringWithRange:sRange];
    
    return type;
}
 
//NSDictionary拆包
+ (NSDictionary *)unpackingDicWith:(NSString *) packing{
    
    if (!packing ) return nil;
    
    NSRange rjson = NSMakeRange(37, packing.length - 37);
    NSString *json = [packing substringWithRange:rjson];
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                        error:&err];
    
    return dic;
}
 
//NSMutableArray拆包
+ (NSMutableArray *) unpackingArrWith:(NSString *)packing WithHeard:(NSString *)str{
 
    if (!packing ) return nil;
    
    NSRange rjson = NSMakeRange(37, packing.length - 37);
    NSString *json = [packing substringWithRange:rjson];
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                        error:nil];
    
    NSMutableArray *array = dic[str];
    
    return array;
    
    
}
 
//发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"交易发送成功");
    [_socket readDataWithTimeout:-1 tag:0];
}
 
//全局唯一
- (GCDAsyncSocket *)socket{
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc]
                   initWithDelegate:self
                   delegateQueue:dispatch_get_main_queue()];
    }
    return _socket;
}
 
 
- (NSMutableData *)completeData{
    if (!_completeData ) {
        _completeData = [[NSMutableData alloc]init];
    }
    return _completeData;
}
 
- (NSInteger)lenght{
    if (!_lenght) {
        _lenght = 0 ;
    }
    return _lenght;
}
 
- (NSThread*)thread{
    if (!_thread) {
        _thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadStart) object:nil];
    }
    return _thread;
}
 
+(instancetype) shareAsncSocket{
    static id _instance;
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

@end
