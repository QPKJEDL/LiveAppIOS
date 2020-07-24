//
//  MineTopView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MineTopView.h"
#import "MineActionsView.h"
#import "UserBriefView.h"
#import "LoginTipView.h"
#import <AFNetworking/AFNetworking.h>
#import "ZBUIImagePickerController.h"
@interface MineTopView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) LoginTipView *loginTipView;
@property (nonatomic, strong) UserBriefView *briefView;
@property (nonatomic, strong) MineActionsView *actionsView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIImagePickerController *picker;
@end
@implementation MineTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _topView.image = [UIImage imageNamed:@"beijing"];
        [self addSubview:self.topView];
        _topView.backgroundColor = [UIColor systemPinkColor];
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-67, self.width, 67)];
        _bottomView.backgroundColor = [UIColor hexColor:@"#F7F9FD"];
        [self addSubview:_bottomView];
        [_bottomView corner:UIRectCornerTopLeft|UIRectCornerTopRight radii:16];
        
        self.briefView = [[UserBriefView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, self.width, self.height-STATUS_AND_NAV_BAR_HEIGHT)];
        [self addSubview:self.briefView];
    
        _actionsView = [[MineActionsView alloc] initWithFrame:CGRectMake(13, 0, self.width-26, 88)];
        [self addSubview:self.actionsView];
        
        [self.briefView.avatarImageView addTarget:self action:@selector(onAvatar) forControlEvents:UIControlEventTouchUpInside];
        
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.modalPresentationStyle = UIModalPresentationFullScreen;
        self.picker.delegate = self;
        self.picker.allowsEditing = true;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _actionsView.top = self.height-_actionsView.height-14;
}

- (void)loadData:(NSDictionary *)data {
    [self.loginTipView setHidden:true];
    [self.briefView setHidden:true];
    if (data != nil) {
        [self.briefView setHidden:false];
        [self.briefView reload:data];
    }else{
        [self.loginTipView setHidden:false];
    }
}

- (void)onAvatar {
    [QMUIAlertController appearance].sheetTitleAttributes = @{NSForegroundColorAttributeName:[UIColor hexColor:@"3dc2d5"],NSFontAttributeName:UIFontBoldMake(20),NSKernAttributeName:@(0)};
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {

    }];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"拍照" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        if ([ABDevice isAvailableCamera]) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [[UIApplication sharedApplication].topViewController presentViewController:self.picker animated:true completion:nil];
        }else{
            QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
            QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"去授权" style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
                [ABDevice gotoAppSetting];
            }];
            QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"无法使用相机，需要您的授权" message:nil preferredStyle:QMUIAlertControllerStyleAlert];
            [alertController addAction:action1];
            [alertController addAction:action2];
            [alertController showWithAnimated:YES];
        }
    }];
    QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"相册" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [[UIApplication sharedApplication].topViewController presentViewController:self.picker animated:true completion:nil];
    }];

    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:nil message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
    alertController.alertTextFieldTextColor = [UIColor redColor];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController showWithAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:true completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self uploadAvatar:image];
}

- (void)uploadAvatar:(UIImage *)imageData {
    [[ABNet shared] uploadWithURL:@"http://129.211.114.135:8933/code/Mycenter/upavater" image:imageData success:^(NSURLSessionDataTask *task, id  responseObject) {
        [[Service shared].account updateInfo:@{@"Avater":responseObject[@"data"][@"avater"]}];
        [self loadData:[Service shared].account.info];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
