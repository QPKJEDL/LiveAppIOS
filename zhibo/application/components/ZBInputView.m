//
//  ZBInputView.m
//  zhibo
//
//  Created by qp on 2020/7/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ZBInputView.h"
@interface ZBInputView ()<QMUITextViewDelegate, QMUIKeyboardManagerDelegate>

@property (nonatomic, strong) QMUIKeyboardManager *manager;
@property (nonatomic, assign) CGFloat distanceFromBottom;
@property (nonatomic, assign) CGFloat keyboardY;

@property (nonatomic, strong) UIControl *maskControl;

@end
@implementation ZBInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maskControl = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.maskControl.backgroundColor = [UIColor blackColor];
        [self.maskControl addTarget:self action:@selector(handleCancelButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        
        self.textViewMinimumHeight = 44;
        self.textView = [[QMUITextView alloc] initWithFrame:self.bounds];
        self.textView.backgroundColor = [UIColor hexColor:@"F7F9FD"];
        self.textView.placeholder = @"有爱评论，说点好听的～";
        self.textView.delegate = self;
        self.textView.placeholderColor = [UIColor grayColor];
        [self addSubview:self.textView];

        self.textView.textContainerInset = UIEdgeInsetsMake(10, 7, 10, 7);
        self.textView.returnKeyType = UIReturnKeySend;
        self.textView.enablesReturnKeyAutomatically = YES;
        self.textView.typingAttributes = @{NSFontAttributeName: UIFontMake(15),
                                           NSParagraphStyleAttributeName: [NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:20]
        };
        // 限制可输入的字符长度
        self.textView.maximumTextLength = 50;

        // 限制输入框自增高的最大高度
        self.textView.maximumHeight = 200;
        self.textView.textColor = [UIColor hexColor:@"222222"];

        self.manager = [[QMUIKeyboardManager alloc] initWithDelegate:self];
        [self.manager addTargetResponder:self.textView];
    }
    return self;
}

- (void)becomeFirstResponder {
    [self.textView becomeFirstResponder];
}

- (void)handleCancelButtonEvent {
    [self.textView resignFirstResponder];
    [self hideMask];
}

#pragma mark - <QMUITextViewDelegate>
// 实现这个 delegate 方法就可以实现自增高
- (void)textView:(QMUITextView *)textView newHeightAfterTextChanged:(CGFloat)height {
    height = fmax(height, self.textViewMinimumHeight);
    BOOL needsChangeHeight = CGRectGetHeight(textView.frame) != height;
    if (needsChangeHeight) {
        self.height = height;
        [self refreshPosition];
    }
}

- (void)textView:(QMUITextView *)textView didPreventTextChangeInRange:(NSRange)range replacementText:(NSString *)replacementText {
//    [QMUITips showWithText:[NSString stringWithFormat:@"文字不能超过 %@ 个字符", @(textView.maximumTextLength)] inView:self.view hideAfterDelay:.8];
}

// 可以利用这个 delegate 来监听发送按钮的事件，当然，如果你习惯以前的方式的话，也可以继续在 textView:shouldChangeTextInRange:replacementText: 里处理
- (BOOL)textViewShouldReturn:(QMUITextView *)textView {
//    [QMUITips showSucceed:[NSString stringWithFormat:@"成功发送文字：%@", textView.text] inView:self.view hideAfterDelay:1];
    [self handleCancelButtonEvent];
    if (self.delegate && [self.delegate respondsToSelector:@selector(zbInputView:text:)]) {
        [self.delegate zbInputView:self text:textView.text];
    }
    self.textView.placeholder = @"有爱评论，说点好听的～";
    textView.text = nil;
    
    // return YES 表示这次 return 按钮的点击是为了触发“发送”，而不是为了输入一个换行符
    return YES;
}

#pragma mark -----

- (void)keyboardWillChangeFrameWithUserInfo:(QMUIKeyboardUserInfo *)keyboardUserInfo {
    __weak __typeof(self)weakSelf = self;
    [QMUIKeyboardManager handleKeyboardNotificationWithUserInfo:keyboardUserInfo showBlock:^(QMUIKeyboardUserInfo *keyboardUserInfo) {
        [QMUIKeyboardManager animateWithAnimated:YES keyboardUserInfo:keyboardUserInfo animations:^{
            self.distanceFromBottom = [QMUIKeyboardManager distanceFromMinYToBottomInView:weakSelf keyboardRect:keyboardUserInfo.endFrame];
            self.keyboardY = keyboardUserInfo.endFrame.origin.y;
            
            [self refreshPosition];
            [self showMask];
        } completion:NULL];
    } hideBlock:^(QMUIKeyboardUserInfo *keyboardUserInfo) {
        self.distanceFromBottom = 0;
        [QMUIKeyboardManager animateWithAnimated:YES keyboardUserInfo:keyboardUserInfo animations:^{
            weakSelf.layer.transform = CATransform3DIdentity;
            [self hideMask];
        } completion:NULL];
    }];
}

- (void)showMask {
    if (self.maskControl.superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.maskControl];
    }
    self.maskControl.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{
        self.maskControl.alpha = 0.1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideMask {
    [UIView animateWithDuration:0.1 animations:^{
        self.maskControl.alpha = 0;
    } completion:^(BOOL finished) {
        [self.maskControl removeFromSuperview];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textView.height = self.height;
}

- (void)refreshPosition {
    
    self.layer.transform = CATransform3DMakeTranslation(0, - _distanceFromBottom - CGRectGetHeight(self.bounds)+44, 0);
}

@end
