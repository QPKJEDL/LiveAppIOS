//
//  UserPromptActionItemView.m
//  zhibo
//
//  Created by qp on 2020/7/15.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UserPromptActionItemView.h"
@interface UserPromptActionItemView()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation UserPromptActionItemView

- (void)setupAdjustContents {
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.font = [UIFont PingFangMedium:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.titleLabel];
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = item[@"title"];
    self.titleLabel.textColor = [UIColor hexColor:item[@"color"]];
    
    if ([item[@"selected"] boolValue]) {
        self.titleLabel.text = item[@"title_hl"];
    }
}

- (void)layoutAdjustContents {
    
}
@end
