//
//  PublishDTViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PublishDTViewController.h"
#import <FSTextView/FSTextView.h>
#import "PickPhotoView.h"
#import <YBImageBrowser/YBImageBrowser.h>
@interface PublishDTViewController ()<PickPhotoViewDelegate, PickPhotoViewDataSource>
@property (nonatomic, strong) FSTextView *textView;
@property (nonatomic, strong) UIButton *topicButton;
@property (nonatomic, strong) PickPhotoView *pickPhotoView;
@property (nonatomic, strong) UIButton *publishButton;
@end

@implementation PublishDTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView = [[FSTextView alloc] initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH-50, 60)];
    _textView.placeholder = @"这一刻的想法";
    _textView.maxLength = 55;
    _textView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_textView];
    
    _topicButton = [[UIButton alloc] initWithFrame:CGRectMake(25, _textView.bottom, 60, 30)];
    [_topicButton setTitle:@"# 话题" forState:UIControlStateNormal];
    [_topicButton setTitleColor:[UIColor hexColor:@"969696"] forState:UIControlStateNormal];
    [self.view addSubview:_topicButton];
    
    _pickPhotoView = [[PickPhotoView alloc] initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH, 105)];
    _pickPhotoView.delegate = self;
    _pickPhotoView.dataSource = self;
    [self.view addSubview:_pickPhotoView];
    
    
    _publishButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 0, 185, 50)];
    [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
    [_publishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_publishButton];
    _publishButton.centerX = self.view.width/2;
    _publishButton.clipsToBounds = true;
    _publishButton.layer.cornerRadius = 25;
    
    [_publishButton gradient:GRADIENTCOLORS direction:0];
    
    
    
    [self refreshLayout];
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
    _topicButton.top = _textView.bottom;
    _pickPhotoView.top = _topicButton.bottom+10;
    _publishButton.top = _pickPhotoView.bottom+160;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
