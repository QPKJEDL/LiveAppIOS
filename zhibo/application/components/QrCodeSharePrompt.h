//
//  QrCodeSharePrompt.h
//  zhibo
//
//  Created by qp on 2020/8/8.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QrCodeSharePrompt : UIView
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) QMUIButton *saveButton;
@property (nonatomic, strong) QMUIButton *deleteButton;
@property (nonatomic, strong) NSString *qrcodeStr;

@end

NS_ASSUME_NONNULL_END
