//
//  XXXXViewController.m
//  zhibo
//
//  Created by qp on 2020/9/4.
//  Copyright © 2020 qp. All rights reserved.
//

#import "XXXXViewController.h"

@interface XXXXItemView: UIView<ABUIListItemViewProtocol>
@property (nonatomic, strong) UILabel *label;
@end

@implementation XXXXItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.font = [UIFont systemFontOfSize:12];
    self.label.textColor = [UIColor redColor];
    self.label.numberOfLines = 0;
    [self addSubview:self.label];
}

- (void)layoutAdjustContents {
    
}

- (void)reload:(NSDictionary *)item {
    self.label.text = item[@"text"];
    self.label.frame = self.bounds;
}

@end

@interface XXXXViewController ()
@property (nonatomic, strong) ABUIListView *mainListView;
@end

@implementation XXXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Game Socket logs";
    self.mainListView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainListView];
    
    NSArray *list = [ABIteration iterationList:[Stack shared].gslogs block:^NSMutableDictionary * _Nonnull(NSMutableDictionary * _Nonnull dic, NSInteger idx) {
        NSString *text = [dic toJSONString];
//        text = [text stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        CGFloat h = [text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)].height;
        dic[@"item.size.height"] = @(h+20);
        dic[@"text"] = text;
        dic[@"native_id"] = @"xxxx";
       return dic;
    }];
    
    [self.mainListView setDataList:list css:@{@"item.rowSpacing":@"10"}];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mainListView.frame = self.view.bounds;
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
