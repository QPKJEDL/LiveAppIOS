//
//  PokerView.m
//  zhibo
//
//  Created by qp on 2020/9/18.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PokerView.h"
@interface PokerRawView : UIView<ABUIListItemViewProtocol>
@property (nonatomic, strong) ABUIBorderLabel *titleLabel;
@property (nonatomic, strong) UIView *cardListView;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PokerRawView

- (void)setupAdjustContents {
    self.backgroundColor = [[UIColor hexColor:@"#3B3B3B"] colorWithAlphaComponent:0.7];
    self.titleLabel = [[ABUIBorderLabel alloc] initWithFrame:CGRectMake(0, 0, 62, self.height)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont PingFangSC:15];
    self.titleLabel.interColor = [UIColor whiteColor];
    self.titleLabel.outerColor = [UIColor hexColor:@"#F72EFF"];
    [self addSubview:self.titleLabel];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.cardListView = [[UIView alloc] initWithFrame:CGRectMake(62, 0, self.width, self.height)];
    [self addSubview:self.cardListView];
    
    self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, self.height-16, self.width-62, 16)];
    [self addSubview:self.desLabel];
    [self.desLabel setHidden:true];
    
    self.desLabel.font = [UIFont PingFangSC:10];
    self.desLabel.textAlignment = NSTextAlignmentCenter;
    self.desLabel.textColor = [UIColor whiteColor];

    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, LINGDIANWU)];
    self.lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self addSubview:self.lineView];
}

- (void)layoutAdjustContents {
    self.lineView.top = self.height-LINGDIANWU;
}

- (void)reload:(NSDictionary *)item {
    
    self.desLabel.text = item[@"result"];
    [self.desLabel setHidden:self.desLabel.text.length == 0];
    
    
    self.titleLabel.text = item[@"title"];
    if ([self.titleLabel.text isEqualToString:@"庄"]) {
        self.desLabel.backgroundColor = [[UIColor hexColor:@"#3C3C3C"] colorWithAlphaComponent:0.7];
    }else{
        self.desLabel.backgroundColor = [[UIColor hexColor:@"#3C3C3C"] colorWithAlphaComponent:0.7];
    }
    
    for (UIView *v in self.cardListView.subviews) {
        [v removeFromSuperview];
    }
    NSArray *list = item[@"list"];
    CGFloat ll = 0;
    for (int i=0; i<list.count; i++) {
        NSDictionary *item = list[i];
        NSString *cm = [item stringValueForKey:@"Cardnum"];
        UIImageView *card = [[UIImageView alloc] initWithFrame:CGRectMake(ll, self.height-34, 23, 34)];
//        card.backgroundColor = [UIColor whiteColor];
        card.image = [UIImage imageNamed:cm];
        [self.cardListView addSubview:card];
        ll = card.right+16;
    }
}

@end

@interface PokerView ()
@property (nonatomic, strong) ABUIListView *listView;
@end
@implementation PokerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.listView = [[ABUIListView alloc] initWithFrame:self.bounds];
        [self addSubview:self.listView];
    }
    return self;
}


- (void)setDataList:(NSArray *)dataList {
    [self.listView setDataList:dataList css:@{
        @"item.rowSpacing":@"0",
        @"item.size.height":@"40"
    }];
}

- (void)setMaxColumn:(int)Column {
    self.width = 62+Column*23+16*Column;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.listView.frame = self.bounds;
}
@end
