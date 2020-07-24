//
//  PhotoListCell.m
//  zhibo
//
//  Created by FaiWong on 2020/4/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PhotoListCell.h"
@interface PhotoListCell ()
@property (nonatomic, strong) UIView *containView;
@end
@implementation PhotoListCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.containView = [[UIView alloc] initWithFrame:self.bounds];
        self.containView.clipsToBounds = true;
        self.containView.layer.cornerRadius = 5;
        [self addSubview:self.containView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.backgroundColor = [UIColor hexColor:@"f3f3f2"];
        [self.containView addSubview:self.imageView];
    }
    return self;
}
@end
