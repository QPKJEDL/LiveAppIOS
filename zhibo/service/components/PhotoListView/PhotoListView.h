//
//  PhotoListView.h
//  zhibo
//
//  Created by FaiWong on 2020/4/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PhotoListView;
@protocol PhotoListViewDelegate <NSObject>


@end

@protocol PhotoListViewDataSource <NSObject>
@required
-(NSInteger)photoListView:(PhotoListView *)photoListView numberOfItemsInSection:(NSInteger)section;
- (NSString *)photoListView:(PhotoListView *)photoListView itemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PhotoListView : UIView
@property (nonatomic, weak) id<PhotoListViewDelegate> delegate;
@property (nonatomic, weak) id<PhotoListViewDataSource> dataSource;
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
