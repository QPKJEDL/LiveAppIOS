//
//  ManagerItemView.m
//  zhibo
//
//  Created by qp on 2020/7/14.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ManagerItemView.h"
@interface ManagerItemView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *jiechuButton;
@end
@implementation ManagerItemView
- (void)setupAdjustContents {
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.textColor = [UIColor hexColor:@"#A5A5A5"];
    self.nameLabel.font = [UIFont PingFangSCBlod:14];
    [self addSubview:self.nameLabel];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.idLabel.textColor = [UIColor hexColor:@"#A5A5A5"];
    self.idLabel.font = [UIFont PingFangSCBlod:14];
    [self addSubview:self.idLabel];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.backgroundColor = [UIColor hexColor:@"f3f3f2"];
    self.avatarImageView.layer.cornerRadius = self.height/2;
    self.avatarImageView.clipsToBounds = true;
    [self addSubview:self.avatarImageView];
    
    self.jiechuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 75, 34)];
    self.jiechuButton.backgroundColor = [UIColor hexColor:@"#FF2A40"];
    [self.jiechuButton setTitle:@"解除" forState:UIControlStateNormal];
    self.jiechuButton.titleLabel.font = [UIFont PingFangSCBlod:14];
    self.jiechuButton.layer.cornerRadius = 34/2;
    self.jiechuButton.clipsToBounds = true;
    [self addSubview:self.jiechuButton];
    [self.jiechuButton setUserInteractionEnabled:false];
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.nameLabel.text = item[@"NickName"];
    [self.nameLabel sizeToFit];
    [self.avatarImageView loadImage:item[@"Account"]];
    
    self.idLabel.text = [NSString stringWithFormat:@"ID:%@", item[@"UserId"]];
    [self.idLabel sizeToFit];
}

- (void)layoutAdjustContents {
    self.avatarImageView.left = 16;
    self.avatarImageView.centerY = self.height/2;
    
    self.nameLabel.left = self.avatarImageView.right+10;
    self.nameLabel.top = self.height/2-self.nameLabel.height-2;
    
    self.idLabel.top = self.height/2+2;
    self.idLabel.left = self.nameLabel.left;
    
    self.jiechuButton.centerY = self.height/2;
    self.jiechuButton.left = self.width-self.jiechuButton.width-15;
}

@end
