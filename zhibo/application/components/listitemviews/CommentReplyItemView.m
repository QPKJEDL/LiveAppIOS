//
//  CommentReplyView.m
//  zhibo
//
//  Created by qp on 2020/7/30.
//  Copyright © 2020 qp. All rights reserved.
//

#import "CommentReplyItemView.h"
@interface CommentReplyItemView ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation CommentReplyItemView

- (void)setupAdjustContents {
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.clipsToBounds = true;
    self.avatarImageView.layer.cornerRadius = 20/2;
    [self addSubview:self.avatarImageView];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nickNameLabel.font = [UIFont PingFangMedium:13];
    self.nickNameLabel.textColor = [UIColor hexColor:@"868687"];
    [self addSubview:self.nickNameLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont PingFangSC:14];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.font = [UIFont PingFangSC:11];
    self.timeLabel.textColor = [UIColor hexColor:@"868687"];
    [self addSubview:self.timeLabel];
}

- (void)layoutAdjustContents {
    self.avatarImageView.left = 0;
    self.nickNameLabel.left = self.avatarImageView.right+10;
    
    self.timeLabel.left = self.nickNameLabel.left;
    self.timeLabel.top = self.nickNameLabel.bottom;
    
    self.contentLabel.left = self.nickNameLabel.left;
    self.contentLabel.top = self.avatarImageView.bottom+2;
    

}

- (void)reload:(NSDictionary *)item {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item[@"avater"]] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.nickNameLabel.text = item[@"nickname"];
    [self.nickNameLabel sizeToFit];
    self.nickNameLabel.height = 15;
    
    self.contentLabel.text = item[@"comment"];
//    [self.contentLabel sizeToFit];
    self.contentLabel.width = [item[@"commentw"] floatValue];
    self.contentLabel.height = [item[@"commenth"] floatValue];
    
    NSString *creatime = item[@"creatime"];
    self.timeLabel.text = [[ABTime shared] howMuchTimePassed:creatime];
    [self.timeLabel sizeToFit];
    self.timeLabel.height = 12;
}

@end
