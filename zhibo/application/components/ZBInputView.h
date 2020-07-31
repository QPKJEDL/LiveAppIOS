//
//  ZBInputView.h
//  zhibo
//
//  Created by qp on 2020/7/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBInputView;
@protocol ZBInputViewDelegate <NSObject>
- (void)zbInputView:(ZBInputView *)zbinputView text:(NSString *)text;
@end
@interface ZBInputView : UIView
@property (nonatomic, weak) id<ZBInputViewDelegate> delegate;
@property(nonatomic, assign) CGFloat textViewMinimumHeight;
@property (nonatomic, strong) QMUITextView *textView;
- (void)becomeFirstResponder;
@end

NS_ASSUME_NONNULL_END
