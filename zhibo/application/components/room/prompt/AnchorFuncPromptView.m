//
//  AnchorFuncPromptView.m
//  zhibo
//
//  Created by qp on 2020/7/12.
//  Copyright © 2020 qp. All rights reserved.
//

#import "AnchorFuncPromptView.h"
@interface AnchorFuncPromptView ()<ABUIListViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ABUIListView *listView;
@end
@implementation AnchorFuncPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = true;
    
        
        self.listView = [[ABUIListView alloc] initWithFrame:self.bounds];
        [self addSubview:self.listView];
        
        NSArray *dataList = @[
            @{
                @"title":@"切换游戏",
                @"icon":@"youxi",
                @"native_id":@"titleimage"
            },
            @{
                @"title":@"超级管理员",
                @"icon":@"guanliyuan",
                @"native_id":@"titleimage"
            },
            @{
                @"title":@"美颜",
                @"icon":@"meiyan",
                @"native_id":@"titleimage"
            },
            @{
                @"title":@"镜头",
                @"icon":@"fanzhuan",
                @"native_id":@"titleimage"
            },
            @{
                @"title":@"下注",
                @"icon":@"youxi",
                @"native_id":@"titleimage"
            },
            @{
                @"title":@"额度转换",
                @"icon":@"jinbi",
                @"native_id":@"titleimage"
            }
        ];
        
        NSDictionary *css = @{@"item.size.width":@"25%", @"item.size.height":@"25%"};
        self.listView.backgroundColor = [[UIColor hexColor:@"#232828"] colorWithAlphaComponent:0.88];
        [self.listView setDataList:dataList css:css];
        self.listView.delegate = self;
    }
    return self;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    if (self.delegate && [self.delegate respondsToSelector:@selector(anchorFuncPromptView:didSelectIndex:item:)]) {
        [self.delegate anchorFuncPromptView:self didSelectIndex:indexPath.row item:item];
    }
}

@end
