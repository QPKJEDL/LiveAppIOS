//
//  KaiBoReadyControl.m
//  zhibo
//
//  Created by qp on 2020/7/9.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPushReadyControl.h"
#import "RoomPushReadyTitleView.h"

@interface RoomPushReadyControl ()<RoomPushReadyTitleViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) QMUIButton *flipButton;
@property (nonatomic, strong) UIButton *zhiboButton;
@property (nonatomic, strong) QMUIButton *beautiButton;

@property (nonatomic, strong) RoomPushReadyTitleView *titleView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, assign) NSInteger gameid;
@property (nonatomic, assign) NSInteger deskid;
@end
@implementation RoomPushReadyControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(5, SYS_STATUSBAR_HEIGHT+10, 44, 44)];
        [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.backButton setImage:[UIImage imageNamed:@"guan"] forState:UIControlStateNormal];
        [self addSubview:self.backButton];
        
        
        self.flipButton = [[QMUIButton alloc] initWithFrame:CGRectMake(self.width-15-44, self.backButton.bottom+56+23, 44, 44)];
        [self.flipButton setImage:[UIImage imageNamed:@"fanzhuan"] forState:UIControlStateNormal];
        [self.flipButton setTitle:@"翻转" forState:UIControlStateNormal];
        [self.flipButton setTitleColor:[UIColor hexColor:@"FFFFFF"] forState:UIControlStateNormal];
        self.flipButton.imagePosition = QMUIButtonImagePositionTop;
        self.flipButton.titleLabel.font = [UIFont PingFangSC:9];
        [self.flipButton addTarget:self action:@selector(onFlip) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.flipButton];
        
        self.beautiButton = [[QMUIButton alloc] initWithFrame:CGRectMake(self.width-15-44, self.flipButton.bottom+20, 44, 44)];
        [self.beautiButton setImage:[UIImage imageNamed:@"meiyan"] forState:UIControlStateNormal];
        [self.beautiButton setTitle:@"美颜" forState:UIControlStateNormal];
        [self.beautiButton setTitleColor:[UIColor hexColor:@"FFFFFF"] forState:UIControlStateNormal];
        self.beautiButton.titleLabel.font = [UIFont PingFangSC:9];
        self.beautiButton.imagePosition = QMUIButtonImagePositionTop;
        [self.beautiButton addTarget:self action:@selector(onMeiYan) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.beautiButton];
        
        self.zhiboButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height-115-44, 228, 44)];
        self.zhiboButton.layer.cornerRadius = 22;
        self.zhiboButton.clipsToBounds = true;
        self.zhiboButton.backgroundColor = [UIColor hexColor:@"#FF2A40"];
        [self.zhiboButton setTitle:@"开始直播" forState:UIControlStateNormal];
        self.zhiboButton.titleLabel.font = [UIFont PingFangMedium:15];
        [self.zhiboButton addTarget:self action:@selector(onStartPush) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.zhiboButton];
        self.zhiboButton.centerX = self.width/2;
        
        self.titleView = [[RoomPushReadyTitleView alloc] initWithFrame:CGRectMake(15, self.backButton.bottom+56, self.width-30-50, 142)];
//        self.titleView.backgroundColor = [[UIColor hexColor:@"#1B3F41"] colorWithAlphaComponent:0.5];
        self.titleView.backgroundColor = [[UIColor hexColor:@"#000000"] colorWithAlphaComponent:0.5];
        self.titleView.layer.cornerRadius = 4;
        self.titleView.clipsToBounds = true;
        self.titleView.delegate = self;
        [self addSubview:self.titleView];
        
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
    }
    return self;
}

#pragma mark --------- local action ---------
- (void)onFlip {
    [[RoomContext shared].pushView flip];
}

- (void)onMeiYan {
    [RP promptBeauty];
}

- (void)backAction {
    [NSRouter dismiss];
}

- (void)setCover:(UIImage *)image {
    [self.titleView setCover:image];
}


- (void)onStartPush {
    if (self.titleView.label == nil || self.titleView.title.length == 0) {
        [ABUITips showError:@"请输入您的标题并选择一个游戏"];
        return;
    }
    [[RoomContext shared].pushPresent setcover:self.titleView.title gameid:self.gameid deskid:self.deskid channel:self.titleView.label];
}

- (void)titleViewOnCover:(RoomPushReadyTitleView *)titleView {
    [QMUIAlertController appearance].sheetTitleAttributes = @{NSForegroundColorAttributeName:[UIColor hexColor:@"FF2A40"],NSFontAttributeName:UIFontBoldMake(20),NSKernAttributeName:@(0)};
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        
    }];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"拍照" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.vc presentViewController:self.picker animated:true completion:nil];
    }];
    QMUIAlertAction *action3 = [QMUIAlertAction actionWithTitle:@"从相册上传" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self.vc presentViewController:self.picker animated:true completion:nil];
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
    [self.titleView setCover:image];
}

- (void)titleViewOnTip:(RoomPushReadyTitleView *)titleView {
    [self endEditing:true];
    [RP promptGameBlock:^(NSInteger gameid, NSInteger deskid, NSString *title) {
        self.gameid = gameid;
        self.deskid = deskid;
        self.titleView.label = title;
    }];
}

- (void)titleViewOnChannel:(RoomPushReadyTitleView *)titleView{
    [self endEditing:true];
    [RP promptChannels:^(NSString * _Nullable title) {
        self.titleView.channel = title;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];

}

@end

