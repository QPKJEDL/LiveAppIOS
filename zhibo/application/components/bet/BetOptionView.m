//
//  BetOptionCell.m
//  zhibo
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BetOptionView.h"

@interface BetOptionView ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) ABUIBorderLabel *titleLabel;
@property (nonatomic, strong) UILabel *oddLabel;

@property (nonatomic, strong) UILabel *betNumLabel;
@end

@implementation BetOptionView

- (void)setupAdjustContents {
    
    self.containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 3, 3)];
    self.containView.layer.cornerRadius = 10;
    self.containView.layer.borderWidth = LINGDIANWU;
    self.containView.layer.borderColor = [UIColor hexColor:@"#19FFCD"].CGColor;
    [self addSubview:self.containView];
    self.containView.backgroundColor = [[UIColor hexColor:@"#1B3F41"] colorWithAlphaComponent:0.58];
    
    self.titleLabel = [[ABUIBorderLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    self.titleLabel.interColor = [UIColor whiteColor];
    self.titleLabel.outerColor = [UIColor redColor];
    self.titleLabel.outerWidth = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.containView addSubview:self.titleLabel];
    
    self.oddLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.oddLabel.font = [UIFont systemFontOfSize:9];
    self.oddLabel.textColor = [UIColor whiteColor];
    self.oddLabel.textAlignment = NSTextAlignmentCenter;
    [self.containView addSubview:self.oddLabel];
    
    
    self.betNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.betNumLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.68];
    self.betNumLabel.layer.cornerRadius = 2;
    self.betNumLabel.clipsToBounds = true;
    self.betNumLabel.font = [UIFont systemFontOfSize:9];
    self.betNumLabel.textColor = [UIColor whiteColor];
    self.betNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.containView addSubview:self.betNumLabel];
    self.betNumLabel.height = 12;
    self.betNumLabel.layer.cornerRadius = self.betNumLabel.height/2;
}

- (void)layoutAdjustContents {
    self.containView.frame = CGRectInset(self.bounds, 3, 3);
    CGFloat h = (self.containView.height-self.titleLabel.height-self.oddLabel.height)/2;
    self.titleLabel.top = h;
    self.oddLabel.top = self.titleLabel.bottom+2;
    
    self.titleLabel.centerX = self.containView.width/2;
    self.oddLabel.centerX = self.containView.width/2;
    
    self.betNumLabel.left = 5;
    self.betNumLabel.top = 5;
}

- (void)reload:(NSDictionary *)data{
    self.titleLabel.text = data[@"title"];
    self.oddLabel.text = data[@"odd"];
    [self.betNumLabel setHidden:true];
    if (data[@"num"] == nil || [data[@"num"] intValue] == 0) {
        self.betNumLabel.text = @"";
    }else{
        self.betNumLabel.text = [NSString stringWithFormat:@"%@", data[@"num"]];
        [self.betNumLabel setHidden:false];
    }
   
    self.titleLabel.outerColor = [UIColor hexColor:data[@"css"][@"title.color"]];
    CGFloat ff = [data[@"css"][@"title.font"] floatValue];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:ff];
    
    [self.titleLabel sizeToFit];
    [self.oddLabel sizeToFit];
    [self.betNumLabel sizeToFit];
    self.betNumLabel.width = MAX(self.betNumLabel.width+8, 30);
    
    
    [self layoutAdjustContents];
    
    self.containView.backgroundColor = [[UIColor hexColor:@"#1B3F41"] colorWithAlphaComponent:0.58];
    if (data[@"selected"] != nil) {
        int selected = [data[@"selected"] intValue];
        if (selected == 1) {
            self.containView.backgroundColor = [UIColor hexColor:@"#C20C0C"];
        }
    }
}

@end
