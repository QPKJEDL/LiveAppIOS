//
//  JnPasswordView.h
//  New_Patient
//
//  Created by Jn_Kindle on 2018/5/28.
//  Copyright © 2018年 新开元 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InputPwdBlock)(NSString *pwd);
typedef void(^CancelBlock)(void);
typedef void(^CertainBlock)(void);

@interface JnPasswordView : NSObject


@property (nonatomic, strong) InputPwdBlock inputPwdBlock;
@property (nonatomic, strong) CancelBlock cancelBlock;
@property (nonatomic, strong) CertainBlock certainBlock;

@property (nonatomic, weak) UILabel *titleLabel;

/**
 *  创建单例模式
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;


/**
 显示密码输入视图

 @param inputPwdBlock 输入内容
 @param cancelBlock 取消
 @param certainBlock 确定
 */
- (void)showPasswordViewWithInputPwd:(InputPwdBlock)inputPwdBlock
                              cancel:(CancelBlock)cancelBlock
                             certain:(CertainBlock)certainBlock;

/**
 取消显示密码输入视图
 */
- (void)dismissPasswordView;

@end
