//
//  PickPhotoAddCell.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PickPhotoAddCell.h"
@interface PickPhotoAddCell ()
@property  (nonatomic, strong) UIImageView *imageView;
@end
@implementation PickPhotoAddCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"jia"];
        [self addSubview:_imageView];
    }
    return self;
}
@end
