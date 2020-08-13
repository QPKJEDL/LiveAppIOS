//
//  RoomComeRaw.m
//  zhibo
//
//  Created by qp on 2020/7/16.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomComeRaw.h"
@interface RoomComeRaw ()
@property (nonatomic, strong) UIControl *containView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, assign) NSInteger uid;
@end
@implementation RoomComeRaw

- (void)layoutAdjustContents {
    self.nameLabel.left = 15;
    self.nameLabel.centerY = self.containView.height/2;
    self.textLabel.centerY = self.containView.height/2;
    self.textLabel.left = self.nameLabel.right+5;
    self.containView.centerY = self.height/2;
}

//创建内容
- (void)setupAdjustContents {
    self.containView = [[UIControl alloc] initWithFrame:self.bounds];
    self.containView.layer.cornerRadius = 10;
    self.containView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    self.containView.clipsToBounds = true;
    [self addSubview:self.containView];
    [self.containView addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLabel = [[QMUILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.textColor = [UIColor hexColor:@"#FF2A40"];
    self.nameLabel.font = [UIFont PingFangMedium:14];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.containView addSubview:self.nameLabel];
    [self.nameLabel setUserInteractionEnabled:false];
    
    self.textLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.textLabel.layer.cornerRadius = 10;
    self.textLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.textLabel.font = [UIFont PingFangMedium:14];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.clipsToBounds = true;
    [self.containView addSubview:self.textLabel];
    [self.textLabel setUserInteractionEnabled:false];
}

//设置数据
- (void)reload:(NSDictionary *)item {
    self.uid = [item[@"uid"] intValue];
    self.nameLabel.text = item[@"name"];
    [self.nameLabel sizeToFit];
    
    self.textLabel.text = @"加入直播间";
    [self.textLabel sizeToFit];
    self.textLabel.height = self.height;
    self.nameLabel.left = 15;
    self.containView.frame = CGRectMake(0, 0, self.nameLabel.width+self.textLabel.width+28, self.height);
    self.superview.width = self.containView.width;
    self.width = self.containView.width;
}

- (void)onButton {
    [RP promptUserWithUid:self.uid];
}

@end
