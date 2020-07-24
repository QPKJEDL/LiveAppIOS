//
//  ListCellLiveComment.m
//  zhibo
//
//  Created by FaiWong on 2020/5/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ListCellLiveComment.h"
@interface ListCellLiveComment ()

@end
@implementation ListCellLiveComment

- (void)setupAdjustContents {
    [super setupAdjustContents];
    self.backgroundColor = [UIColor clearColor];
    self.containView.layer.cornerRadius = 10;
    self.containView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    self.contentView.clipsToBounds = true;

    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.titleLabel.numberOfLines = 0;
}

- (void)reload:(NSDictionary *)item {
    NSString *name = item[@"name"];
    NSString *title = [NSString stringWithFormat:@"%@:%@", item[@"name"], item[@"content"]];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:title];;
    [attrString addAttributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"3dc2d5"]} range:NSMakeRange(0, name.length)];
    self.titleLabel.attributedText = attrString;
    
    CGFloat contentHeight = [item[@"contentHeight"] floatValue];
    CGFloat contentWeight = [item[@"contentWeight"] floatValue];
    self.titleLabel.frame = CGRectMake(14, 10, contentWeight, contentHeight);
    self.containView.frame = CGRectMake(0, 0, self.titleLabel.width+28, self.titleLabel.height+20);
}

- (void)layoutAdjustContents {

}
@end
