//
//  PopularizeListViewController.m
//  zhibo
//
//  Created by qp on 2020/8/4.
//  Copyright © 2020 qp. All rights reserved.
//

#import "PopularizeListViewController.h"
#import "QrCodeSharePrompt.h"
#import <HXPhotoTools.h>
@interface PopularizeListViewController ()<INetData, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, assign) NSInteger codeid;
@property (nonatomic, strong) QrCodeSharePrompt *qsp;

@end

@implementation PopularizeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    QMUIButton *btn = [[QMUIButton alloc] initWithFrame:CGRectMake(35, 21, SCREEN_WIDTH-70, 42)];
    btn.layer.cornerRadius = 42/2;
    btn.clipsToBounds = true;
    [btn setTitle:@"添加二维码" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont PingFangSC:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor hexColor:@"FF2828"]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.listView.delegate = self;
    [self.view addSubview:self.listView];
    [self.listView adapterSafeArea];
    self.listView.delegate = self;
    [self.listView setupPullRefresh];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchPostUri:URI_ACCOUNT_POPULARIZE_CODELIST params:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listView.frame = CGRectMake(0, 82, SCREEN_WIDTH, self.view.height-82);
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    if ([req.uri isEqualToString:URI_ACCOUNT_POPULARIZE_CODELIST]) {
        [self.listView endPullRefreshing];
        [self.listView setDataList:obj[@"list"] css:@{@"item.size.height":@(74)}];
    }else{
        [ABUITips showError:@"删除成功"];
         [self fetchPostUri:URI_ACCOUNT_POPULARIZE_CODELIST params:nil];
    }
    
}

- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [self.listView endPullRefreshing];
    [ABUITips showSucceed:err.message];
}

- (void)onButton {
    [NSRouter gotoPopularize];
}

- (void)listViewOnHeaderPullRefresh:(ABUIListView *)listView {
    [self fetchPostUri:URI_ACCOUNT_POPULARIZE_CODELIST params:nil];
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    self.qsp = [[QrCodeSharePrompt alloc] initWithFrame:CGRectMake(26, 0, SCREEN_WIDTH-26-26, SCREEN_HEIGHT)];
    [self.qsp.mainImageView sd_setImageWithURL:[NSURL URLWithString:item[@"bgimage"]] placeholderImage:nil];
    [self.qsp.saveButton addTarget:self action:@selector(onSave) forControlEvents:UIControlEventTouchUpInside];
    [self.qsp.deleteButton addTarget:self action:@selector(onDelete) forControlEvents:UIControlEventTouchUpInside];
    self.qsp.qrcodeStr = item[@"qrcode"];
    self.codeid = [item[@"id"] intValue];
    [[ABUIPopUp shared] show:self.qsp from:ABPopUpDirectionCenter];
}

- (void)onSave {
    [[ABUIPopUp shared] remove];
    [HXPhotoTools savePhotoToCustomAlbumWithName:nil photo:[ABTools getImageViewWithView:self.qsp.mainImageView]];
    [ABUITips showSucceed:@"保存成功"];
}

- (void)onDelete {
    [[ABUIPopUp shared] remove];
    [self fetchPostUri:URI_ACCOUNT_POPULARIZE_DELETE params:@{@"codeid":@(self.codeid)}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
