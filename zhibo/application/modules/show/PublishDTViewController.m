//
//  PublishDTViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PublishDTViewController.h"
#import "PickPhotoView.h"
#import <YBImageBrowser/YBImageBrowser.h>
#import <HXPhotoPicker/HXPhotoPicker.h>

#define kPhotoViewMargin 12.0f

@interface PublishDTViewController ()<PickPhotoViewDelegate, PickPhotoViewDataSource, HXPhotoViewDelegate, INetData>
@property (nonatomic, strong) QMUITextView *textView;
@property (nonatomic, strong) UIButton *topicButton;
@property (nonatomic, strong) HXPhotoView *pickPhotoView;
@property (nonatomic, strong) UIButton *publishButton;

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) HXPhotoManager *manager;
@end

@implementation PublishDTViewController


- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.maxNum = 9;
        _manager.configuration.cameraCanLocation = false;
        _manager.configuration.cameraCellShowPreview = false;
        _manager.configuration.openCamera = false;
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView = [[QMUITextView alloc] initWithFrame:CGRectMake(25, 10, SCREEN_WIDTH-50, 60)];
    _textView.placeholderColor = [UIColor hexColor:@"#8C939B"];
    _textView.font = [UIFont PingFangSC:16];
    _textView.placeholder = @"这一刻的想法";
    _textView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_textView];
    
    CGFloat width = self.view.frame.size.width;
    self.pickPhotoView = [HXPhotoView photoManager:self.manager scrollDirection:UICollectionViewScrollDirectionVertical];
    self.pickPhotoView.frame = CGRectMake(0, self.textView.bottom+10, width, 0);
    self.pickPhotoView.collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    self.pickPhotoView.delegate = self;
    self.pickPhotoView.outerCamera = YES;
    self.pickPhotoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
    self.pickPhotoView.showAddCell = YES;
    self.pickPhotoView.collectionView.scrollEnabled = YES;
    [self.pickPhotoView.collectionView reloadData];
    [self.view addSubview:self.pickPhotoView];
    
    _publishButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 0, 185, 50)];
    [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
    [_publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_publishButton addTarget:self action:@selector(onPublish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_publishButton];
    _publishButton.centerX = self.view.width/2;
    _publishButton.clipsToBounds = true;
    _publishButton.layer.cornerRadius = 25;

    [_publishButton gradient:GRADIENTCOLORS direction:0];
    

    [self refreshLayout];
}

- (void)onPublish {
    [self fetchPostUri:URI_MOMENTS_PUBLISH params:@{@"content":self.textView.text}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    [ABUITips showSucceed:@"发布成功"];
    [self.navigationController popViewControllerAnimated:true];
}

- (NSInteger)pickPhotoViewNumberOfItems {
    return 1;
}

- (void)pickPhotoViewDidSelectAdd {
    __weak __typeof(self) weakSelf  = self;
    UIAlertController *alert =  [[UIAlertController alloc] init];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        [[DeviceUtil shared] takep];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[DeviceUtil shared] selectPhotos:weakSelf];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
    
}

- (void)pickPhotoViewDidSelectItem:(NSInteger)index {
    
}

- (void)refreshLayout {
    _pickPhotoView.top = _textView.bottom+10;
    _publishButton.top = _pickPhotoView.bottom+160;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath isAddItem:(BOOL)isAddItem photoView:(HXPhotoView *)photoView{
//    if (isAddItem) {
//        return CGSizeMake(150, 150);
//    }
    CGFloat width;
    NSInteger index = indexPath.item + 1;
    if (index % 6 == 0) {
        width = self.view.hx_w - kPhotoViewMargin * 2;
    }else if ((index - 4) % 6 == 0  || (index - 5) % 6 == 0) {
        width = (self.view.hx_w - kPhotoViewMargin * 2 - photoView.spacing) / 2;
    }else {
        width = (self.view.hx_w - photoView.spacing * 2 - kPhotoViewMargin * 2) / 3;
    }
    
    return CGSizeMake(width, width);
}
- (CGFloat)photoViewHeight:(HXPhotoView *)photoView {
    return self.view.hx_h - kPhotoViewMargin * 2 - hxNavigationBarHeight;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
