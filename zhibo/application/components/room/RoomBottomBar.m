//
//  RoomBottomBar.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomBottomBar.h"
@interface RoomBottomBar ()<QMUITextViewDelegate, QMUIKeyboardManagerDelegate>
@property (nonatomic, strong) QMUITextView *textView;
@property (nonatomic, strong) QMUIKeyboardManager *manager;
@property (nonatomic, strong) UILabel *inputLabel;

@property (nonatomic, assign) CGFloat distanceFromBottom;
@end
@implementation RoomBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadInput];
        [self loadButtons];
    }
    return self;
}

#pragma mark ----------- input text -----------
- (void)loadInput {
    self.textView = [[QMUITextView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 44)];
    self.textView.placeholder = @"一起来聊天吧～";
    self.textView.delegate = self;
    [self addSubview:self.textView];
    
    self.textView.placeholderColor = UIColorPlaceholder; // 自定义 placeholder 的颜色
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 7, 10, 7);
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.enablesReturnKeyAutomatically = YES;
    self.textView.typingAttributes = @{NSFontAttributeName: UIFontMake(15),
                                       NSParagraphStyleAttributeName: [NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:20],
//                                       NSForegroundColorAttributeName: self.textView.textColor
    };
    // 限制可输入的字符长度
    self.textView.maximumTextLength = 50;
    
    // 限制输入框自增高的最大高度
    self.textView.maximumHeight = 200;
    
    self.manager = [[QMUIKeyboardManager alloc] initWithDelegate:self];
    [self.manager addTargetResponder:self.textView];
    
    _inputLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 98, 33)];
    _inputLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _inputLabel.clipsToBounds = true;
    _inputLabel.layer.cornerRadius = 33/2;
    _inputLabel.text = @"一起聊天吧~";
    _inputLabel.userInteractionEnabled = true;
    _inputLabel.textAlignment = NSTextAlignmentCenter;
    _inputLabel.font = [UIFont systemFontOfSize:13];
    _inputLabel.textColor = [UIColor whiteColor];
    [self addSubview:_inputLabel];
    _inputLabel.centerY = (self.height-TI_HEIGHT)/2;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onInput)];
    [_inputLabel addGestureRecognizer:tap];
}

- (void)onInput {
    [self.textView becomeFirstResponder];
}

// 实现这个 delegate 方法就可以实现自增高
- (void)textView:(QMUITextView *)textView newHeightAfterTextChanged:(CGFloat)height {
    height = fmax(height, 44);
    BOOL needsChangeHeight = CGRectGetHeight(textView.frame) != height;
    if (needsChangeHeight) {
//        [self setNeedsLayout];
//        [self layoutIfNeeded];
        self.textView.height = height;
        [self refreshPosition];
    }
}

- (void)textView:(QMUITextView *)textView didPreventTextChangeInRange:(NSRange)range replacementText:(NSString *)replacementText {
    [ABUITips showError:[NSString stringWithFormat:@"文字不能超过 %@ 个字符", @(textView.maximumTextLength)]];
}

- (BOOL)textViewShouldReturn:(QMUITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomBar:onText:)]) {
        [self.delegate bottomBar:self onText:textView.text];
    }
    textView.text = nil;
    [textView resignFirstResponder];
    return YES;
}

- (void)keyboardWillChangeFrameWithUserInfo:(QMUIKeyboardUserInfo *)keyboardUserInfo {
    __weak __typeof(self)weakSelf = self;
    [QMUIKeyboardManager handleKeyboardNotificationWithUserInfo:keyboardUserInfo showBlock:^(QMUIKeyboardUserInfo *keyboardUserInfo) {
        [QMUIKeyboardManager animateWithAnimated:YES keyboardUserInfo:keyboardUserInfo animations:^{
            self.distanceFromBottom = [QMUIKeyboardManager distanceFromMinYToBottomInView:weakSelf keyboardRect:keyboardUserInfo.endFrame];
            [self refreshPosition];
        } completion:NULL];
    } hideBlock:^(QMUIKeyboardUserInfo *keyboardUserInfo) {
        self.distanceFromBottom = 0;
        [QMUIKeyboardManager animateWithAnimated:YES keyboardUserInfo:keyboardUserInfo animations:^{
            weakSelf.textView.layer.transform = CATransform3DIdentity;
            self.commentView.layer.transform = CATransform3DIdentity;
        } completion:NULL];
    }];
}

- (void)refreshPosition {
    self.textView.layer.transform = CATransform3DMakeTranslation(0, - _distanceFromBottom - CGRectGetHeight(self.textView.bounds), 0);
    self.commentView.layer.transform = CATransform3DMakeTranslation(0, - _distanceFromBottom+TI_HEIGHT, 0);
}

- (void)btnAction:(UIButton *)btn {
    //关闭
    if (btn.tag == 0) {
        [self.delegate bottomBarOnClose:self];
    }else if (btn.tag == 1) {
        [self.delegate bottomBarOnMore:self];
    }else{
        [self.delegate bottomBarOnGift:self];
    }
}

#pragma mark ------------- buttons -----------
- (void)loadButtons {
    NSArray *imageNames = @[@"guanbi", @"qita", @"liwu-1"]; //按钮倒叙，从屏幕右侧开始创建
    NSInteger index = 0;
    for (NSString *name in imageNames) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-15-33*(index+1)-10*index, 0, 33, 33)];
        [btn setTag:index];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.centerY = (self.height-TI_HEIGHT)/2;
        index++;
    }
}

@end
