//
//  InputItemView.m
//  zhibo
//
//  Created by qp on 2020/7/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "InputItemView.h"
@interface InputItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, strong) NSString *key;
@end
@implementation InputItemView

- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self.containView addSubview:self.titleLabel];
    
    self.textField = [[QMUITextField alloc] initWithFrame:CGRectMake(114, 0, SCREEN_WIDTH-15-114, self.height)];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
    [self.containView addSubview:self.textField];
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    
    self.key = item[@"key"];
    self.textField.secureTextEntry = false;
    if ([self.key containsString:@"pwd"]) {
        self.textField.secureTextEntry = true;
    }
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:item[@"placeholder"] attributes:
    @{NSForegroundColorAttributeName:[UIColor hexColor:@"cccccc"],
                 NSFontAttributeName:[UIFont systemFontOfSize:12]
         }];
    self.textField.attributedPlaceholder = attrString;
    if (item[@"value"] != nil) {
        self.textField.text = [NSString stringWithFormat:@"%@", [Service shared].account.bank[item[@"value"]]];
        if ([self.textField.text isEqualToString:@"0"]) {
            self.textField.text = @"";
        }
    }
    if (item[@"text"] != nil) {
        self.textField.text = item[@"text"];
        [[Stack shared] set:item[@"text"] key:item[@"key"]];
    }
    
    self.textField.textColor = [UIColor hexColor:@"222222"];
    [self.textField setEnabled:true];
    if (item[@"max"] != nil) {
        self.textField.maximumTextLength = [item[@"max"] intValue];
    }
    if ([item[@"disable"] boolValue]) {
        self.textField.textColor = [UIColor hexColor:@"999999"];
        [self.textField setEnabled:false];
    }
    self.textField.keyboardType = UIKeyboardTypeDefault;
    if ([item[@"tt"] isEqualToString:@"number"]) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    [self textFieldChanged];
}

- (void)layoutAdjustContents {
    self.titleLabel.left = 15;
    self.titleLabel.centerY = self.height/2;
}

- (void)textFieldChanged {
    [[Stack shared] set:_textField.text key:self.key];
}

@end
