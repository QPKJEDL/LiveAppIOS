//
//  RoomAudienceItemView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomAudienceItemView.h"
@interface RoomAudienceItemView ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@end

@implementation RoomAudienceItemView

- (void)setupAdjustContents {
    self.avatarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.backgroundColor = [UIColor hexColor:@"f3f3f2"];
    self.avatarImageView.layer.cornerRadius = self.height/2;
    self.avatarImageView.clipsToBounds = true;
    [self addSubview:self.avatarImageView];
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    [self.avatarImageView sd_setImageWithURL:item[@"Avater"] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
}

- (void)layoutAdjustContents {
    
}

@end
