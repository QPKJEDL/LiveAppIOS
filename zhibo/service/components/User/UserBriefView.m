//
//  UserBriefView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/25.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UserBriefView.h"
@interface UserBriefView ()
@property (nonatomic, strong) UIView *containView;
@end
@implementation UserBriefView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.containView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.containView];
        
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 25, 66, 66)];
        _avatarImageView.layer.cornerRadius = 33;
        _avatarImageView.clipsToBounds = true;
        [_avatarImageView setUserInteractionEnabled:true];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.containView addSubview:_avatarImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont PingFangSCBlod:20];
        [self.containView addSubview:_nameLabel];
        
        _idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _idLabel.textColor = [UIColor hexColor:@"F7F8FA"];
        _idLabel.font = [UIFont fontMicrosoftYaHei:12];
        [self.containView addSubview:_idLabel];
        
        _followCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _followCountLabel.textColor = [UIColor hexColor:@"FFFFFF"];
        _followCountLabel.font = [UIFont fontMicrosoftYaHei:12];
        [self.containView addSubview:_followCountLabel];
        [_followCountLabel addTarget:self action:@selector(onFollow) forControlEvents:UIControlEventTouchUpInside];
        
        _fansCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _fansCountLabel.textColor = [UIColor hexColor:@"FFFFFF"];
        _fansCountLabel.font = [UIFont fontMicrosoftYaHei:12];
        [self.containView addSubview:_fansCountLabel];
        [_fansCountLabel addTarget:self action:@selector(onFans) forControlEvents:UIControlEventTouchUpInside];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        
        _zanCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _zanCountLabel.textColor = [UIColor hexColor:@"FFFFFF"];
        _zanCountLabel.font = [UIFont fontMicrosoftYaHei:12];
        [self.containView addSubview:_zanCountLabel];
    }
    return self;
}

- (void)onFollow {
//    [NSRouter gotoUserList:@"关注列表"];
}

- (void)onFans {
//    [NSRouter gotoUserList:@"粉丝列表"];
}

- (void)reload:(NSDictionary *)data {
    NSString *name = data[@"NickName"];
    NSString *avatar = data[@"Avater"];
    NSString *aid = data[@"UserId"];
    
    NSString *fansCount = [NSString stringWithFormat:@"粉丝 %@", data[@"Fans"]];
    NSString *followCount = [NSString stringWithFormat:@"关注 %@", data[@"Followed"]];
    NSString *zanCount = [NSString stringWithFormat:@"获赞 %@", data[@"Talk"]];
    
    _nameLabel.text = name;
    [_nameLabel sizeToFit];
    
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.idLabel.text = [NSString stringWithFormat:@"直播ID：%@", aid];
    [self.idLabel sizeToFit];
    
    self.followCountLabel.text = followCount;
    self.fansCountLabel.text = fansCount;
    self.zanCountLabel.text = zanCount;
    [self.followCountLabel sizeToFit];
    [self.fansCountLabel sizeToFit];
    [self.zanCountLabel sizeToFit];
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.top = 101;
    self.nameLabel.left = 23;

    
    self.idLabel.top = 129;
    self.idLabel.left = 23;
    
    self.followCountLabel.top = 158;
    self.followCountLabel.left = 24;
    
    self.fansCountLabel.top = 158;
    self.fansCountLabel.left = self.followCountLabel.right+22;
    
    self.zanCountLabel.top = 158;
    self.zanCountLabel.left = self.fansCountLabel.right+22;
}

@end
