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
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *key;
@end
@implementation InputItemView

- (void)setupAdjustContents {
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
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
        self.textField.text = [Service shared].account.bank[item[@"value"]];
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
