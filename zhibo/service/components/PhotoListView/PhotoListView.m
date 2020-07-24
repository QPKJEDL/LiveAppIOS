//
//  PhotoListView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PhotoListView.h"
#import "PhotoListCell.h"
@interface PhotoListView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *listCollectionView;
@end

@implementation PhotoListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(105, 105);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;


        self.listCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.listCollectionView.delegate = self;
        self.listCollectionView.dataSource = self;
        self.listCollectionView.backgroundColor = UIColor.clearColor;
        [self.listCollectionView registerClass:[PhotoListCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:self.listCollectionView];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource photoListView:self numberOfItemsInSection:section];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *absoluteURL = [self.dataSource photoListView:self itemAtIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:absoluteURL]];
    return cell;
}

- (void)reloadData {
    [self.listCollectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.listCollectionView.frame = self.bounds;
}
@end
