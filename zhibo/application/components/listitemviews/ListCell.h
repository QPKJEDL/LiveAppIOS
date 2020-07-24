//
//  ListCell.h
//  zhibo
//
//  Created by qp on 2020/4/29.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//@protocol ListItemProtocol <NSObject>
//
//- (NSString *)icon;
//- (NSString *)title;
//- (NSString *)subTitle;
//
//
//@end

typedef enum : NSUInteger {
    ListViewItemActionKeyPostComment
} ListViewItemActionKey;

@protocol ListCellDelegate <NSObject>

- (void)listCellOnActionIndexPath:(NSIndexPath *)indexPath key:(ListViewItemActionKey)key;

@end




@interface ListCell : UICollectionViewCell
@property (nonatomic, weak) id<ListCellDelegate> delegate;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *accessoryView;

//创建内容
- (void)setupAdjustContents;
//布局内容
- (void)layoutAdjustContents;
//设置数据
- (void)reload:(NSDictionary *)item;
@end

NS_ASSUME_NONNULL_END
