//
//  GameSelectPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/11.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GamesPromptView.h"

@interface GamesPromptView ()<ABUIListViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ABUIListView *listView;
@end
@implementation GamesPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        self.titleLabel.text = @"选择游戏";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont PingFangSC:14];
        self.titleLabel.textColor = [UIColor hexColor:@"#313131"];
        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor whiteColor];
        
        self.listView = [[ABUIListView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-44)];
        self.listView.bounces = false;
        [self addSubview:self.listView];
        [self.listView addLineDirection:LineDirectionTop color:[UIColor hexColor:@"dedede"] width:1];
        
        NSArray *dataList = @[
            @{
                @"id":@(1),
                @"title":@"百家乐",
                @"icon":@"baijiale",
                @"color":@"A5A5A5",
                @"native_id":@"titleimage"
            },
            @{
                @"id":@(2),
                @"title":@"龙虎",
                @"icon":@"longhu",
                @"color":@"A5A5A5",
                @"native_id":@"titleimage"
            },
            @{
                @"id":@(3),
                @"title":@"牛牛",
                @"icon":@"niuniu",
                @"color":@"A5A5A5",
                @"native_id":@"titleimage"
            },
            @{
                @"id":@(4),
                @"title":@"三公",
                @"icon":@"sangong",
                @"color":@"A5A5A5",
                @"native_id":@"titleimage"
            },
            @{
                @"id":@(5),
                @"title":@"A89",
                @"icon":@"a89",
                @"color":@"A5A5A5",
                @"native_id":@"titleimage"
            }
        ];
        self.listView.delegate = self;
        [self.listView setDataList:dataList css:@{@"item.size.width":@"20%", @"item.size.height":@"73", @"item.row.spacing":@"0"}];
        
    }
    return self;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (self.delegate && [self.delegate respondsToSelector:@selector(gamesPromptView:didSelectIndex:item:)]) {
        [self.delegate gamesPromptView:self didSelectIndex:indexPath.row item:item];
    }
}

@end
