//
//  GameBetResultView.m
//  zhibo
//
//  Created by qp on 2020/8/20.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameBetResultView.h"
#import "BetTransform.h"
@interface GameBetResultView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *contetView;
@property (nonatomic, strong) UIButton *closeButton;
@end
@implementation GameBetResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor hexColor:@"161823"] colorWithAlphaComponent:0.8];
        self.layer.cornerRadius = 8;
        self.clipsToBounds = true;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        [self.titleLabel setText:@"本局结果"];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont PingFangSC:18];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        
        self.contetView = [[UIView alloc] initWithFrame:CGRectMake(30, 40, self.width-60, self.height)];
        [self addSubview:self.contetView];
        [self.contetView addLineDirection:LineDirectionTop color:[UIColor whiteColor] width:LINGDIANWU];
        
        self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.height-40-15, self.width/2, 40)];
        [self.closeButton addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
        [self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.closeButton.titleLabel.font = [UIFont PingFangSC:18];
        self.closeButton.layer.borderWidth = 1;
        self.closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.closeButton.layer.cornerRadius = 20;
        self.closeButton.clipsToBounds = true;
        self.closeButton.centerX = self.width/2;
        [self addSubview:self.closeButton];
    }
    return self;
}

- (void)onClose {
    [[ABUIPopUp shared] remove];
}

- (void)setData:(NSDictionary *)data {
    
    NSInteger gid = [data[@"GameType"] intValue];
    NSString *resultStr = [[BetTransform shared] getBetDescriptionGid:gid winner:data[@"Result"]];
    
    
    NSArray *arr = @[
        @{
            @"title":@"号台：",
            @"value":data[@"Desk_name"]
        },
        @{
            @"title":@"靴次：",
            @"value":[data stringValueForKey:@"Boot_num"]
        },
        @{
            @"title":@"铺次：",
            @"value":[data stringValueForKey:@"Pave_num"]
        },
        @{
            @"title":@"开台结果：",
            @"value":resultStr
        },
        @{
            @"title":@"可用余额：",
            @"value":[NSString stringWithFormat:@"%.2f", [data[@"Balance"] floatValue]]
        },
        @{
            @"title":@"本局输赢：",
            @"value":[data stringValueForKey:@"Sumgetmoney"]
        }

    ];
    
    CGFloat top = 0;
    
    for (int i=0; i<arr.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, 100, 30)];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont PingFangSC:16];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.text = arr[i][@"title"];
        [self.contetView addSubview:titleLabel];
        
        
        NSString *str = arr[i][@"value"];
        CGSize strSize = [str sizeWithFont:[UIFont PingFangSC:16] constrainedToSize:CGSizeMake(self.contetView.width-100, 200)];
        CGFloat h = MAX(strSize.height, 30);

        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, top, self.contetView.width-100, h)];
        textLabel.numberOfLines = 0;
        [textLabel setText:str];
        textLabel.font = [UIFont PingFangSC:16];
        textLabel.textColor = [UIColor whiteColor];
        
        [self.contetView addSubview:textLabel];
        top = textLabel.bottom;
        
    }
    self.closeButton.top = top+40+10;
    self.height = self.closeButton.bottom+10;
}

@end
