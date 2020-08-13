//
//  RoomMessageWelcomeItemView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomMessageWelcomeItemView.h"
@interface RoomMessageWelcomeItemView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *textLabel;
@end
@implementation RoomMessageWelcomeItemView

- (void)setupAdjustContents {
    
    self.containView = [[UIView alloc] initWithFrame:self.bounds];
    self.containView.layer.cornerRadius = 10;
    self.containView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    self.containView.clipsToBounds = true;
    [self addSubview:self.containView];
    
    self.nameLabel = [[QMUILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.textColor = [UIColor hexColor:@"#FF2A40"];
    self.nameLabel.font = [UIFont PingFangMedium:14];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    
    self.textLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.textLabel.layer.cornerRadius = 10;
    self.textLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.textLabel.font = [UIFont PingFangMedium:14];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.clipsToBounds = true;
    [self addSubview:self.textLabel];
    
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.nameLabel.text = item[@"name"];
    [self.nameLabel sizeToFit];
    
    self.textLabel.text = @"来了";
    [self.textLabel sizeToFit];
    
//    NSDictionary *css = item[@"css"];
    
    self.nameLabel.left = 15;
    self.containView.frame = CGRectMake(0, 0, self.nameLabel.width+self.textLabel.width+28, self.nameLabel.height+20);
}

- (void)layoutAdjustContents {
    self.nameLabel.centerY = self.height/2;
    self.textLabel.centerY = self.height/2;
    self.textLabel.left = self.nameLabel.right+5;
}


@end
