//
//  TencentCOS.m
//  zhibo
//
//  Created by qp on 2020/8/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TencentCOS.h"
#import "AppDelegate.h"
@interface TencentCOS ()<QCloudSignatureProvider, QCloudCredentailFenceQueueDelegate, INetData>
@property (nonatomic, strong) NSDictionary *uploadKeys;
@property (nonatomic, strong) TencentCOSSuccessBlock block;
@property (nonatomic, strong) NSString *foler;
@property (nonatomic, strong) NSArray<UIImage *> * images;
@end
@implementation TencentCOS

- (void)uploadImage:(UIImage *)image foler:(NSString *)foler success:(nonnull TencentCOSSuccessBlock)success{
    [self uploadImages:@[image] foler:foler success:success];
}

- (void)uploadImages:(NSArray<UIImage *> *)images foler:(NSString *)foler success:(nonnull TencentCOSSuccessBlock)success {
    self.block = success;
    self.foler = foler;
    self.images = images;
    [self refreshSecretInfo];
}

- (void)_upload {
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    for (int i=0; i<self.images.count; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%@/%@%i", self.foler, [ABTime timestamp], i];
        QCloudCOSXMLUploadObjectRequest* put = [QCloudCOSXMLUploadObjectRequest new];
        // 本地文件路径
        // 存储桶名称，格式为 BucketName-APPID
        put.bucket = @"downloadapk-1302167200";
        // 对象键，是对象在 COS 上的完整路径，如果带目录的话，格式为 "dir1/object1"
        put.object = fileName;
        //需要上传的对象内容。可以传入NSData*或者NSURL*类型的变量
        put.body =  UIImageJPEGRepresentation(self.images[i], 0.5);
        //监听上传结果
        [put setFinishBlock:^(QCloudUploadObjectResult *outputObject, NSError *error) {
            NSLog(@"%@", fileName);
            NSString *url = outputObject.location;
            if (url == nil) {
                url = @"";
            }
            [urls addObject:url];
            if (urls.count == self.images.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.block(urls);
                });
            }
        }];
        [[QCloudCOSTransferMangerService defaultCOSTransferManager] UploadObject:put];
    }
}

+ (TencentCOS *)shared {
    static TencentCOS *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化临时密钥脚手架
        self.credentialFenceQueue = [QCloudCredentailFenceQueue new];
        self.credentialFenceQueue.delegate = self;
    }
    return self;
}

- (void)setup {
    QCloudServiceConfiguration* configuration = [QCloudServiceConfiguration new];
    QCloudCOSXMLEndPoint* endpoint = [[QCloudCOSXMLEndPoint alloc] init];
    // 服务地域简称，例如广州地区是 ap-guangzhou
    endpoint.regionName = @"ap-shanghai";
    // 使用 HTTPS
    endpoint.useHTTPS = true;
    configuration.endpoint = endpoint;
    // 密钥提供者为自己
    configuration.signatureProvider = self;
    // 初始化 COS 服务示例
    [QCloudCOSXMLService registerDefaultCOSXMLWithConfiguration:configuration];
    [QCloudCOSTransferMangerService registerDefaultCOSTransferMangerWithConfiguration:
        configuration];
}


- (void)refreshSecretInfo {
    [self fetchPostUri:URI_TENCENT_COSSECRET params:nil];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    self.uploadKeys = obj;
    [self _upload];
}



#pragma mark ------------- sig ----------
- (void) fenceQueue:(QCloudCredentailFenceQueue * )queue requestCreatorWithContinue:(QCloudCredentailFenceQueueContinue)continueBlock
{
    //这里同步从后台服务器获取临时密钥
    //...

    QCloudCredential* credential = [QCloudCredential new];
    // 临时密钥 SecretId
    credential.secretID = self.uploadKeys[@"tmpSecretId"];
    // 临时密钥 SecretKey
    credential.secretKey = self.uploadKeys[@"tmpSecretKey"];
    // 临时密钥 Token
    credential.token = self.uploadKeys[@"sessionToken"];
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


@end
