//
//  AvatarView.m
//  zhibo
//
//  Created by qp on 2020/7/7.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AvatarView.h"
@interface AvatarView ()
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation AvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
