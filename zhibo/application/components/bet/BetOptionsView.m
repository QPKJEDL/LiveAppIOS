//
//  BetOptionsView.m
//  zhibo
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BetOptionsView.h"
#import "BetOptionView.h"
@interface BetOptionsView ()<ABUIListViewDelegate, ABUIListViewDataSource>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) NSArray *dataList;
@end
@implementation BetOptionsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectIndex = -1;
        
        self.listView = [[ABUIListView alloc] initWithFrame:self.bounds];
        self.listView.delegate = self;
        self.listView.dataSource = self;
        [self addSubview:self.listView];
    }
    return self;
}

- (void)reload:(NSArray *)dataList {
    self.dataList = dataList;
    [self.listView setDataList:dataList css:nil];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    self.selectIndex = indexPath.row;
    [self.delegate betOptionsView:self didSelectItemAtIndex:indexPath.row];
    [listView reloadData];
}

- (CGSize)listView:(ABUIListView *)listView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = self.dataList[indexPath.row];
    NSDictionary *css = item[@"css"];
    NSString *cssw = css[@"w"];
    NSString *cssh = css[@"h"];
    
    CGFloat w = [ABNumber numberFromPercentString:cssw tt:self.listView.width];
    CGFloat h = [ABNumber numberFromPercentString:cssh tt:self.listView.height];
    
    return CGSizeMake(w, h);
}


@end
