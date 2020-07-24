//
//  NearByViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "NearByViewController.h"
#import "AnchorPresent.h"
#import "ABUIListView.h"
@interface NearByViewController ()<AnchorPresentDelegate, ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *listView;
@property (nonatomic, strong) AnchorPresent *present;
@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    _listView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    _listView.delegate = self;
    [self.view addSubview:_listView];
    
    self.present = [[AnchorPresent alloc] init];
    self.present.delegate = self;
//    [self.present getAnchorList:self.props];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _listView.frame = self.view.bounds;
}


- (void)onReceiveAnchorList{
    NSString *w = [NSString stringWithFormat:@"%f", ceil((SCREEN_WIDTH-3*5)/2.0)];
    [self.listView setDataList:self.present.anchorList css:@{@"item.size.width":w, @"item.size.height":w, @"section.inset.right":@"5", @"section.inset.left":@"5", @"item.rowSpacing":@"5"}];
}

#pragma mark --
//- (NSInteger)anchorListView:(AnchorListView *)anchorListView numberOfAnchorsInSection:(NSInteger)section {
//    return  self.present.anchorList.count;
//}
//
//- (AnchorItem *)anchorListView:(AnchorListView *)anchorListView itemForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return self.present.anchorList[indexPath.row];
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
