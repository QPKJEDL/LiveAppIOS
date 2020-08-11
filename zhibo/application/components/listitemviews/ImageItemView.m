//
//  ImageItemView.m
//  zhibo
//
//  Created by qp on 2020/7/28.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ImageItemView.h"
@interface ImageItemView ()
@property (nonatomic, strong) UIImageView *containImageView;
@end
@implementation ImageItemView

- (void)setupAdjustContents {
    
    self.containImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.containImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.containImageView.clipsToBounds = true;
    self.containImageView.layer.cornerRadius = 5;
    self.containImageView.backgroundColor = [UIColor hexColor:@"dedede"];
    [self addSubview:self.containImageView];
}

- (void)layoutAdjustContents {
    
}

- (void)reload:(NSDictionary *)item {
    [self.containImageView sd_setImageWithURL:[NSURL URLWithString:item[@"src"]]];
}

@end
