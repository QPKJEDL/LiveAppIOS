//
//  GameResultPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameResultPromptView.h"
@interface GameResultPromptView ()<ABUIListViewDelegate, INetData>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) UIButton *closeButton;
@end
@implementation GameResultPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor hexColor:@"#1B3F41"] colorWithAlphaComponent:0.8];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, 200, 36)];
        self.titleLabel.layer.cornerRadius = 36/2;
        self.titleLabel.clipsToBounds = true;
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        self.titleLabel.text = @"本局结果";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textColor = [UIColor hexColor:@"26E2DE"];
        [self addSubview:self.titleLabel];
        self.titleLabel.centerX = self.width/2;
        
        
        self.listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom+20, self.width, self.height-self.titleLabel.bottom-100)];
        self.listView.delegate = self;
        [self addSubview:self.listView];
        
        self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.listView.bottom+20, self.width/2, 40)];
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

- (void)refreshWithGid:(NSInteger)gid winKey:(NSString *)winKey {
    [self fetchUri:URI_GAME_RESULTS params:@{@"game_id":@(gid), @"winner":winKey}];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    NSString *winKey = [NSString stringWithFormat:@"%@", req.params[@"winner"]];
    NSArray *winKeys = [winKey componentsSeparatedByString:@","];
    NSArray *list = [ABIteration iterationList:obj[@"list"] block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        
        NSString *r = dic[@"r"];
        BOOL iswin = false;
        if ([winKeys containsObject:r]) {
            iswin = true;
        }

        dic[@"native_id"] = @"gameresultitem";
        dic[@"a"] = dic[@"title"];
        dic[@"b"] = @"";
        dic[@"c"] = iswin?@"赢":@"输";
        if ([winKey isEqualToString:@"作废"]) {
            dic[@"c"] = @"废";
        }
        
        return dic;
    }];
    
    [self setList:list];
}

- (void)setList:(NSArray *)list {
    [self.listView setDataList:list css:@{
        @"item.size.width":@"100%",
        @"item.size.height":@"60"
    }];
}


@end
