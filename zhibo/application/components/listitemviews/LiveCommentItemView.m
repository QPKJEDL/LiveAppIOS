//
//  LiveCommentItemView.m
//  zhibo
//
//  Created by qp on 2020/6/30.
//  Copyright © 2020 qp. All rights reserved.
//

#import "LiveCommentItemView.h"
@interface LiveCommentItemView ()
@property (nonatomic, strong) UIControl *containView;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, assign) NSInteger uid;
@end

@implementation LiveCommentItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor clearColor];
    self.containView = [[UIControl alloc] initWithFrame:self.bounds];
    self.containView.layer.cornerRadius = 10;
    self.containView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    self.containView.clipsToBounds = true;
    [self addSubview:self.containView];
    [self.containView addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];

    self.titleLabel = [[QMUILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
}

- (void)reload:(NSDictionary *)item {
    self.uid = [item[@"uid"] intValue];
    NSString *name = item[@"name"];
    NSString *title = [NSString stringWithFormat:@"%@:%@", item[@"name"], item[@"content"]];
    if (name.length == 0) {
         title = [NSString stringWithFormat:@"%@%@", item[@"name"], item[@"content"]];
    }
   
//    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
//    attach.image = [UIImage imageNamed:@"phone"];
//    attach.bounds = CGRectMake(0, 0 , 30, self.titleLabel.font.pointSize);
//    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
//    [textAttrStr appendAttributedString:imgStr];
    self.titleLabel.textColor = [UIColor whiteColor];
    if (item[@"color"] != nil) {
        self.titleLabel.textColor = [UIColor hexColor:item[@"color"]];
    }
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:title];;
    [attrString addAttributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"FF2A40"]} range:NSMakeRange(0, name.length)];
    self.titleLabel.attributedText = attrString;
    
    NSDictionary *css = item[@"css"];
    
    CGFloat contentHeight = [css[@"h"] floatValue];
    CGFloat contentWeight = [css[@"w"] floatValue];
    self.titleLabel.frame = CGRectMake(14, 10, contentWeight, contentHeight);
    self.containView.frame = CGRectMake(0, 0, self.titleLabel.width+28, self.titleLabel.height+20);
}

- (void)onButton {
    [RP promptUserWithUid:self.uid];
}

- (void)layoutAdjustContents {

}
@end
