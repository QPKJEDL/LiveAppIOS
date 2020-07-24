//
//  PickPhotoView.m
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PickPhotoView.h"
#import "PickPhotoCell.h"
#import "PickPhotoAddCell.h"
@interface PickPhotoView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *listCollectionView;
@end

@implementation PickPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat itemWidth = ceil((self.width-50-10)/3);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemWidth, 100);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
        layout.minimumInteritemSpacing = 0;
        
        layout.minimumLineSpacing = 5;
        
    
        self.listCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.listCollectionView.delegate = self;
        self.listCollectionView.dataSource = self;
        self.listCollectionView.backgroundColor = UIColor.clearColor;
        [self.listCollectionView registerClass:[PickPhotoCell class] forCellWithReuseIdentifier:@"cell"];
        [self.listCollectionView registerClass:[PickPhotoAddCell class] forCellWithReuseIdentifier:@"cell2"];
        [self addSubview:self.listCollectionView];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pickPhotoViewNumberOfItems)]) {
        return  [self.dataSource pickPhotoViewNumberOfItems];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PickPhotoAddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell  = [collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[PickPhotoAddCell class]]) {
        [self.delegate pickPhotoViewDidSelectAdd];
    }else{
        [self.delegate pickPhotoViewDidSelectItem:indexPath.row];
    }
}

@end
