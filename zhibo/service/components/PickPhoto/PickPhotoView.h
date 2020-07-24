//
//  PickPhotoView.h
//  zhibo
//
//  Created by FaiWong on 2020/4/23.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PickPhotoViewDelegate <NSObject>

- (void)pickPhotoViewDidSelectItem:(NSInteger)index;
- (void)pickPhotoViewDidSelectAdd;

@end

@protocol PickPhotoViewDataSource <NSObject>

- (NSInteger)pickPhotoViewNumberOfItems;
//- (void)pickPhotoViewDidSelectAdd;

@end

@interface PickPhotoView : UIView
@property (nonatomic, weak) id<PickPhotoViewDataSource> dataSource;
@property (nonatomic, weak) id<PickPhotoViewDelegate> delegate;
//- (void)reload;
//- (void)setItemList:(NSArray *)itemList;
@end

NS_ASSUME_NONNULL_END
