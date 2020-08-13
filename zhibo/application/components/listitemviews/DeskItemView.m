//
//  DeskItemView.m
//  zhibo
//
//  Created by qp on 2020/7/12.
//  Copyright © 2020 qp. All rights reserved.
//

#import "DeskItemView.h"
@interface DeskItemView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation DeskItemView

- (void)setupAdjustContents {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 34)];
    self.titleLabel.font = [UIFont PingFangSCBlod:14];
    self.titleLabel.textColor = [UIColor hexColor:@"#353535"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.layer.borderColor = [UIColor hexColor:@"#FF2A40"].CGColor;
    self.titleLabel.clipsToBounds = true;
    self.titleLabel.layer.borderWidth = LINGDIANWU;
    self.titleLabel.layer.cornerRadius = 34/2;
    [self addSubview:self.titleLabel];
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = item[@"DeskName"];
    [self.titleLabel sizeToFit];
    self.titleLabel.width = MAX(self.titleLabel.width+28, 75);
    self.titleLabel.height = 34;
    
    BOOL selected = [extra[@"selected"] boolValue];
    if (selected) {
        self.titleLabel.backgroundColor = [UIColor hexColor:@"#FF2A40"];
        self.titleLabel.textColor = [UIColor whiteColor];
    }else{
        self.titleLabel.backgroundColor = [UIColor hexColor:@"#FFFFFF"];
        self.titleLabel.textColor = [UIColor hexColor:@"#353535"];
    }
}

- (void)layoutAdjustContents {
    self.titleLabel.centerX = self.width/2;
    self.titleLabel.centerY = self.height/2;
}
@end
