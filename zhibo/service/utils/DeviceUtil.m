//
//  DeviceUtil.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "DeviceUtil.h"
#import <Photos/Photos.h>

@interface DeviceUtil ()
@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation DeviceUtil
+ (DeviceUtil *)shared {
    static DeviceUtil *instance = nil;
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
        _picker = [[UIImagePickerController alloc] init];
//        _picker.delegate = self;
        _picker.allowsEditing = YES;
    }
    return self;
}

- (void)saveImageToPhoto:(UIImage *)image {
    [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",@"保存失败");
        } else {
            NSLog(@"%@",@"保存成功");
        }
    }];
}

- (BOOL)isCameraValid {
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypeCamera];
    
//    [self takePhoto:nil success:<#^(NSDictionary *dic)success#>]
}

- (void)takePhoto:(UIViewController *)vc success:(void(^)(NSDictionary * dic))success {
    // 如果拍摄的摄像头可用
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        // 将sourceType设为UIImagePickerControllerSourceTypeCamera代表拍照或拍视频
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置拍摄照片
        _picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 设置使用手机的后置摄像头（默认使用后置摄像头）
        _picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置使用手机的前置摄像头。
        //picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        // 设置拍摄的照片允许编辑
        _picker.allowsEditing =YES;
    
    }else{
        
        NSLog(@"模拟器无法打开摄像头");
    }
    // 显示picker视图控制器
    [vc presentViewController:_picker animated:YES completion:nil];
}

#pragma mark - 选取照片
- (void)selectPhotos:(UIViewController *)vc {
    
    // 设置选择载相册的图片或视频
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //是否允许编辑
    _picker.allowsEditing =NO;
    // 显示picker视图控制器
    [vc presentViewController:_picker animated:YES completion:nil];
}

//  用户选中图片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
//    //获得编辑过的图片
//    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
////    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
//
//    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    [self startLoading];
//    [RequestManager uploadAvatorImage:image success:^(NSDictionary *responsObject) {
//        NSLog(@"%@", responsObject);
//        self.dic[@"smallAvatarUrl"] = responsObject[@"smallAvatarUrl"];
//        self.dic[@"avatarUrl"] = responsObject[@"avatarUrl"];
//        [[LocalManager sharedInstance] updateUserInfo:self.dic];
//        [self.tableview reloadData];
//
//        [self stopLoading];
//    } fail:^(NSError *error) {
//        NSLog(@"%@", [error description]);
//        [self stopLoading];
//    }];
}

@end
