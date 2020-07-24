//
//  HomeNavView.m
//  zhibo
//
//  Created by qp on 2020/7/6.
//  Copyright © 2020 qp. All rights reserved.
//

#import "HomeNavView.h"
@interface HomeNavView ()
@property (nonatomic, strong) UIView *containView;
@property (nonnull, strong) QMUIButton *messageButton;
@end
@implementation HomeNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, SYS_STATUSBAR_HEIGHT, self.width, self.height-SYS_STATUSBAR_HEIGHT)];
        [self addSubview:self.containView];
        
        _messageButton = [[QMUIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-15, 0, 20, 20)];
        [_messageButton setImage:[UIImage imageNamed:@"xiaoxi"] forState:UIControlStateNormal];
        _messageButton.adjustsImageWhenHighlighted = false;
        [_messageButton addTarget:self action:@selector(messageButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.containView addSubview:_messageButton];
        _messageButton.qmui_outsideEdge = UIEdgeInsetsMake(-10, -10, -10, -10);


        UIControl *searchWrapper = [[UIControl alloc] initWithFrame:CGRectMake(15, 0, self.width-30-20-10, 30)];
        [searchWrapper addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        searchWrapper.backgroundColor = [UIColor hexColor:@"#F7F9FD"];
        searchWrapper.layer.cornerRadius = 15;
        [self.containView addSubview:searchWrapper];


        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 14, 14)];
        searchIcon.image = [UIImage imageNamed:@"shousuo"];
        [searchWrapper addSubview:searchIcon];
        searchIcon.centerY = searchWrapper.height/2;

        UILabel *searchTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        searchTextLabel.text = @"搜索你喜欢的博主";
        searchTextLabel.textColor = [[UIColor hexColor:@"#C2CAD5"] colorWithAlphaComponent:0.73];
        searchTextLabel.font = [UIFont systemFontOfSize:11];
        [searchWrapper addSubview:searchTextLabel];
        [searchTextLabel sizeToFit];
        searchTextLabel.centerX = searchWrapper.width/2;
        searchTextLabel.centerY = searchWrapper.height/2;
        
        searchIcon.left = searchTextLabel.left-searchIcon.width-7;
        
        _messageButton.centerY = searchWrapper.centerY = self.containView.height/2;
    }
    return self;
}

- (void)searchAction {
    [NSRouter gotoSearch];
}

- (void)messageButtonAction {
    [NSRouter gotoMessagePage:1];
}

@end
