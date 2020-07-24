//
//  BetCoinsView.m
//  zhibo
//
//  Created by qp on 2020/6/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BetCoinsView.h"
#import "BetCoinCell.h"
@interface BetCoinsView()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *coinCollectionView;
@property (nonatomic, strong) NSArray *coins;
@end

@implementation BetCoinsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 50);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 15;
        
        self.coinCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50) collectionViewLayout:layout];
        self.coinCollectionView.showsHorizontalScrollIndicator = false;
        self.coinCollectionView.bounces = false;
        self.coinCollectionView.backgroundColor = [UIColor clearColor];
        self.coinCollectionView.delegate = self;
        self.coinCollectionView.dataSource = self;
        [self.coinCollectionView registerClass:[BetCoinCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:self.coinCollectionView];
    }
    return self;
}


- (void)reload:(NSArray *)dataList {
    self.selectIndex = -1;
    self.coins = dataList;
    [self.coinCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.coins.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BetCoinCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell reload:self.coins[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate betCoinsView:self didSelectItemAtIndex:indexPath.row];
    [self.coinCollectionView reloadData];
}

@end
