//
//  MomentsItemView.m
//  zhibo
//
//  Created by qp on 2020/7/27.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MomentItemView.h"
#import <YBImageBrowser.h>
#import "CommentView.h"
@interface MomentItemView ()<ABUIListViewDelegate, INetData>
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *followButton;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) ABUIListView *photoListView;

@property (nonatomic, strong) QMUIButton *likeButton;
@property (nonatomic, strong) QMUIButton *commentButton;

@property (nonatomic, strong) NSArray *medias;

@property (nonatomic, strong) NSDictionary *data;
@end
@implementation MomentItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 46, 46)];
    self.avatarImageView.layer.cornerRadius = 46/2;
    self.avatarImageView.clipsToBounds = true;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.avatarImageView];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nickNameLabel.font = [UIFont PingFangSCBlod:17];
    self.nickNameLabel.textColor = [UIColor hexColor:@"#707B87"];
    [self addSubview:self.nickNameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.font = [UIFont PingFangSCBlod:14];
    self.timeLabel.textColor = [UIColor hexColor:@"#8C939B"];
    [self addSubview:self.timeLabel];
    
    self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62, 24)];
    self.followButton.titleLabel.font = [UIFont PingFangSC:12];
    self.followButton.clipsToBounds = true;
    self.followButton.layer.cornerRadius = 12;
    [self.followButton addTarget:self action:@selector(onFollow) forControlEvents:UIControlEventTouchUpInside];
    [self.followButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
    [self addSubview:self.followButton];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont PingFangSC:17];
    self.contentLabel.textColor = [UIColor hexColor:@"#373C4E"];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    self.photoListView = [[ABUIListView alloc] initWithFrame:CGRectMake(15, 118, self.width-30, 100)];
    self.photoListView.delegate = self;
    [self addSubview:self.photoListView];
    
    
    self.commentButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [self.commentButton setImage:[UIImage imageNamed:@"pingjia"] forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[UIColor hexColor:@"#B7BBC3"] forState:UIControlStateNormal];
    self.commentButton.titleLabel.font = [UIFont PingFangMedium:14];
    [self.commentButton addTarget:self action:@selector(onComment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.commentButton];
    [self.commentButton setSpacingBetweenImageAndTitle:5];
    self.commentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.likeButton = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [self.likeButton setTitleColor:[UIColor hexColor:@"#B7BBC3"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"hongdianz"] forState:UIControlStateSelected];
    [self addSubview:self.likeButton];
    self.likeButton.titleLabel.font = [UIFont PingFangMedium:14];
    [self.likeButton setSpacingBetweenImageAndTitle:5];
    self.likeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.likeButton addTarget:self action:@selector(onLike) forControlEvents:UIControlEventTouchUpInside];
    [self layoutAdjustContents];
}

- (void)layoutAdjustContents {
    self.nickNameLabel.top = self.avatarImageView.centerY-self.nickNameLabel.height;
    self.timeLabel.top = self.avatarImageView.centerY;
    
    self.nickNameLabel.left = self.avatarImageView.right+15;
    self.timeLabel.left = self.avatarImageView.right+15;
    
    self.followButton.left = self.width-15-self.followButton.width;
    self.followButton.centerY = self.avatarImageView.centerY;
    
    self.contentLabel.left = self.avatarImageView.left;
    self.contentLabel.top = self.avatarImageView.bottom+13;
    
    self.commentButton.left = self.avatarImageView.left;
    self.commentButton.top = self.height-self.commentButton.height-10;
    
    self.likeButton.left = self.commentButton.right;
    self.likeButton.top = self.height-self.commentButton.height-10;
    
    self.photoListView.top = self.contentLabel.bottom+17;
    if (self.contentLabel.height == 0) {
        self.photoListView.top = self.contentLabel.top;
    }
}

- (void)reload:(NSDictionary *)item {
    self.data = item;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item[@"avatar"]] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.nickNameLabel.text = item[@"nickname"];
    [self.nickNameLabel sizeToFit];
    
    NSString *time = item[@"creatime"];
    self.timeLabel.text = [[ABTime shared] howMuchTimePassed:time];;
    [self.timeLabel sizeToFit];
    
    self.contentLabel.text = item[@"content"];
    [self.contentLabel sizeToFit];
    
    [self.commentButton setTitle:item[@"comment_count"] forState:UIControlStateNormal];
    [self.likeButton setTitle:item[@"like_count"] forState:UIControlStateNormal];
    
    self.medias = item[@"medias"];
    
    self.contentLabel.width = [item[@"contentw"] floatValue];
    self.contentLabel.height = [item[@"contenth"] floatValue];
    
    [self.photoListView setHidden:true];
    if (item[@"medias"] != nil) {
        [self.photoListView setHidden:false];
        CGFloat w = floor((SCREEN_WIDTH-30-10)/3);
        [self.photoListView setDataList:item[@"medias"] css:@{
            @"item.size.width":@(w),
            @"item.size.height":@(w),
            @"item.rowSpacing":@"5",
        }];
    }
    self.photoListView.height = [item[@"mediash"] floatValue];
    [self.likeButton setSelected:[item[@"like"] intValue] == 1];
    
    
    [self.followButton setSelected:[item[@"IsFollowed"] boolValue]];
    self.followButton.backgroundColor = [UIColor hexColor:@"#FF2A40"];
    if (self.followButton.isSelected) {
        self.followButton.backgroundColor = [UIColor hexColor:@"#999999"];
    }
}

- (void)onFollow {
    if (self.followButton.isSelected) {
        [[Service shared] unfollowUserWithUid:[self.data[@"live_uid"] intValue]];
    }else{
        [[Service shared] followUserWithUid:[self.data[@"live_uid"] intValue]];
    }
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    
    NSMutableArray *datas = [NSMutableArray array];
    [self.medias enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 网络图片
        YBIBImageData *data = [YBIBImageData new];
        data.imageURL = [NSURL URLWithString:obj[@"src"]];
//        data.projectiveView = [listView itemViewAtIndexPath:indexPath];
        [datas addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = indexPath.row;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    [browser show];
}

- (void)onComment {
    CommentView *v = [[CommentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.6)];
    v.data = self.data;
    [v loadData:[self.data[@"live_uid"] intValue] zone_id:[self.data[@"zone_id"] intValue]];
    [v corner:UIRectCornerTopLeft|UIRectCornerTopRight radii:20];
    v.clipsToBounds = true;
    [[ABUIPopUp shared] show:v from:ABPopUpDirectionBottom];
}

- (void)onLike {
    if (self.likeButton.isSelected) {
        return;
    }
    
    [[Service shared] likeMomentWithUid:[self.data[@"live_uid"] intValue] zone_id:[self.data[@"zone_id"] intValue]];

}

@end
