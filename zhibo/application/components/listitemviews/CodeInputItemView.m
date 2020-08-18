//
//  CodeInputItemView.m
//  zhibo
//
//  Created by qp on 2020/8/15.
//  Copyright © 2020 qp. All rights reserved.
//

#import "CodeInputItemView.h"
@interface CodeInputItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *key;
@end
@implementation CodeInputItemView

- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor hexColor:@"222222"];
    [self.containView addSubview:self.titleLabel];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(114, 0, SCREEN_WIDTH-15-114, self.height)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
    [self.containView addSubview:self.textField];
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    
    self.key = item[@"key"];
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
    if ([item[@"disable"] isEqualToString:@"count"]) {
        if (self.textField.text.length > 0) {
            self.textField.textColor = [UIColor hexColor:@"999999"];
            [self.textField setEnabled:false];
        }
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
