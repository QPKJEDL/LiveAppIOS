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
@property (nonatomic, strong) UIControl *qrcodeImageViewControl;
@property (nonatomic, strong) UIImageView *qrcodeImageView;
@property (nonatomic, strong) UILabel *qrcodeLabel;

@end
@implementation QrCodeSharePrompt

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height*0.75)];
        self.mainImageView.backgroundColor = [UIColor hexColor:@"FF2B2B"];
        self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.mainImageView.clipsToBounds = true;
        [self.mainImageView setUserInteractionEnabled:true];
        [self addSubview:self.mainImageView];
        self.mainImageView.centerY = self.height/2;
        
        self.qrcodeImageViewControl = [[UIControl alloc] initWithFrame:self.mainImageView.bounds];
        [self.mainImageView addSubview:self.qrcodeImageViewControl];
        
        self.qrcodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainImageView.height-100-40, 100, 100)];
        [self.mainImageView addSubview:self.qrcodeImageView];
        
        self.qrcodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.mainImageView.width, 44)];
        self.qrcodeLabel.text = @"保存二维码";
        self.qrcodeLabel.textColor = [UIColor whiteColor];
        self.qrcodeLabel.font = [UIFont PingFangSC:14];
        self.qrcodeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.qrcodeLabel];
        self.qrcodeLabel.top = self.qrcodeImageView.bottom+self.mainImageView.top;
        
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

- (void)onImageAction {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[ABUIPopUp shared] remove];
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
