//
//  GiftRankItemView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftRankItemView.h"
@interface GiftRankItemView ()
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *giftNumLabel;
@end
@implementation GiftRankItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setupAdjustContents {
    self.nameLabel = [[QMUILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.textColor = [UIColor hexColor:@"#474747"];
    self.nameLabel.font = [UIFont PingFangMedium:14];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.nameLabel];
    
    self.numLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.numLabel.layer.cornerRadius = 10;
    self.numLabel.textColor = [UIColor hexColor:@"#474747"];
    self.numLabel.font = [UIFont PingFangMedium:14];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.clipsToBounds = true;
    [self addSubview:self.numLabel];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    self.avatarImageView.clipsToBounds = true;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.layer.cornerRadius = 12;
    [self addSubview:self.avatarImageView];
    
    self.giftNumLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.giftNumLabel.layer.cornerRadius = 10;
    self.giftNumLabel.textColor = [UIColor hexColor:@"#000000"];
    self.giftNumLabel.font = [UIFont PingFangMedium:17];
    self.giftNumLabel.textAlignment = NSTextAlignmentRight;
    self.giftNumLabel.clipsToBounds = true;
    [self addSubview:self.giftNumLabel];
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.nameLabel.text = item[@"Nickname"];
    [self.nameLabel sizeToFit];
    if (indexPath.row %2 == 0) {
        self.backgroundColor = [UIColor hexColor:@"#F9F8F9"];
    }else{
        self.backgroundColor = [UIColor hexColor:@"#FFFFFF"];
    }
    
    self.numLabel.text = [NSString stringWithFormat:@"%li", (long)indexPath.row+1];
    self.numLabel.font = [UIFont PingFangMedium:13];
    if (indexPath.row == 0) {
        self.numLabel.backgroundColor = [UIColor hexColor:@"#FFBA00"];
        self.numLabel.textColor = [UIColor whiteColor];
    }
    else if (indexPath.row == 1) {
        self.numLabel.backgroundColor = [UIColor hexColor:@"#A3AEBD"];
        self.numLabel.textColor = [UIColor whiteColor];
    }
    else if (indexPath.row == 2) {
        self.numLabel.backgroundColor = [UIColor hexColor:@"#C8A98D"];
        self.numLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.numLabel.textColor = [UIColor hexColor:@"#DCDCDC"];
        self.numLabel.font = [UIFont PingFangMedium:17];
    }
    
    [self.avatarImageView sd_setImageWithURL:item[@"Avater"] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
//    [self.avatarImageView loadImage:item[@"Avatar"]];
    
    self.giftNumLabel.text = item[@"cmoney"];
    [self.giftNumLabel sizeToFit];
    
    self.nameLabel.width = self.width/3;
}

- (void)layoutAdjustContents {
    self.numLabel.centerY = self.height/2;
    self.nameLabel.centerY = self.height/2;
    self.avatarImageView.centerY = self.height/2;
    self.giftNumLabel.centerY = self.height/2;
    self.numLabel.left = 25;
    self.avatarImageView.left = 82;
    self.nameLabel.left = self.avatarImageView.right+10;
    self.giftNumLabel.left = self.width-15-self.giftNumLabel.width;
}

@end
