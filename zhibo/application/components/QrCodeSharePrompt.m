//
//  QrCodeSharePrompt.m
//  zhibo
//
//  Created by qp on 2020/8/8.
//  Copyright © 2020 qp. All rights reserved.
//

#import "QrCodeSharePrompt.h"
@interface QrCodeSharePrompt ()
@property (nonatomic, strong) UIView *actionView;
@property (nonatomic, strong) UIImageView *qrcodeImageView;

@end
@implementation QrCodeSharePrompt

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-80)];
        self.mainImageView.backgroundColor = [UIColor hexColor:@"FF2B2B"];
        self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.mainImageView];
        
        self.qrcodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height-80-150, 100, 100)];
        [self.mainImageView addSubview:self.qrcodeImageView];
        
        self.actionView = [[UIView alloc] initWithFrame:CGRectMake(-26, 0, SCREEN_WIDTH, 71)];
        self.actionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.actionView];
        
        self.saveButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 140, 42)];
        [self.saveButton setBackgroundColor:[UIColor hexColor:@"#FF2B2B"]];
        [self.saveButton setTitle:@"保存二维码" forState:UIControlStateNormal];
        self.saveButton.titleLabel.font = [UIFont PingFangSC:14];
        [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.saveButton.layer.cornerRadius = 21;
        self.saveButton.clipsToBounds = true;
        [self.actionView addSubview:self.saveButton];
        
        self.deleteButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 140, 42)];
        [self.deleteButton setBackgroundColor:[UIColor hexColor:@"#FF2B2B"]];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.deleteButton.titleLabel.font = [UIFont PingFangSC:14];
        self.deleteButton.layer.cornerRadius = 21;
        self.deleteButton.clipsToBounds = true;
        [self.actionView addSubview:self.deleteButton];
        self.qrcodeImageView.centerX = self.width/2;
    }
    return self;
}

- (void)setQrcodeStr:(NSString *)qrcodeStr {
    _qrcodeStr = qrcodeStr;
    self.qrcodeImageView.image = [ABTools generateQRCodeWithString:qrcodeStr Size:self.qrcodeImageView.width];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.actionView.top = self.height-self.actionView.height;
    
    self.saveButton.left = self.actionView.width/2-self.saveButton.width-13;
    self.deleteButton.left = self.actionView.width/2+13;
    self.saveButton.centerY = self.actionView.height/2;
    self.deleteButton.centerY = self.actionView.height/2;
}

@end
