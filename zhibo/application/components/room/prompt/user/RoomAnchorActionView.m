//
//  AnchorActionView.m
//  zhibo
//
//  Created by qp on 2020/7/15.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomAnchorActionView.h"
@interface RoomAnchorActionView ()
@end
@implementation RoomAnchorActionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, floor(self.width/4), self.height)];
//        [self.followButton setTitle:@"+关注" forState:UIControlStateNormal];
//        [self.followButton setTitleColor:[UIColor hexColor:@"#2EE1EB"] forState:UIControlStateNormal];
//        self.followButton.titleLabel.font = [UIFont PingFangSC:12];
//        [self addSubview:self.followButton];
//
//        self.managerButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-15-floor(self.width/4), 0, floor(self.width/4), self.height)];
//        [self.managerButton setTitle:@"设置管理员" forState:UIControlStateNormal];
//        [self.managerButton setTitle:@"解除管理员" forState:UIControlStateSelected];
//        [self.managerButton setTitleColor:[UIColor hexColor:@"#2EE1EB"] forState:UIControlStateNormal];
//        self.managerButton.titleLabel.font = [UIFont PingFangSC:12];
//        [self addSubview:self.managerButton];
//
//        self.forbiddenButton = [[UIButton alloc] initWithFrame:CGRectMake(self.managerButton.left-floor(self.width/4), 0, floor(self.width/4), self.height)];
//        [self.forbiddenButton setTitle:@"禁言" forState:UIControlStateNormal];
//        [self.forbiddenButton setTitle:@"解除禁言" forState:UIControlStateSelected];
//        [self.forbiddenButton setTitleColor:[UIColor hexColor:@"#2EE1EB"] forState:UIControlStateNormal];
//        self.forbiddenButton.titleLabel.font = [UIFont PingFangSC:12];
//        [self addSubview:self.forbiddenButton];
//
//        self.ttButton = [[UIButton alloc] initWithFrame:CGRectMake(self.forbiddenButton.left-floor(self.width/4), 0, floor(self.width/4), self.height)];
//        [self.ttButton setTitle:@"踢人" forState:UIControlStateNormal];
//        [self.ttButton setTitleColor:[UIColor hexColor:@"#2EE1EB"] forState:UIControlStateNormal];
//        self.ttButton.titleLabel.font = [UIFont PingFangSC:12];
//        [self addSubview:self.ttButton];
    }
    return self;
}

- (void)setActions:(NSArray *)actions {
    CGFloat w = floor(self.width/actions.count);
    for (int i=0; i<actions.count; i++) {
        NSDictionary *dic = actions[i];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(w*i, 0, w, self.height)];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor hexColor:@"#2EE1EB"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont PingFangSC:12];
        [self addSubview:button];
    }
}

@end
