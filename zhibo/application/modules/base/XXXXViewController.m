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
@property (nonatomic, strong) UILabel *timelabel;
@end

@implementation XXXXItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.timelabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.timelabel.font = [UIFont systemFontOfSize:10];
    self.timelabel.textColor = [UIColor blackColor];
    [self addSubview:self.timelabel];
    
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.font = [UIFont systemFontOfSize:10];
    self.label.textColor = [UIColor redColor];
    self.label.numberOfLines = 0;
    [self addSubview:self.label];
}

- (void)layoutAdjustContents {
    self.label.frame = CGRectMake(0, self.timelabel.bottom, self.width, self.height-12);
}

- (void)reload:(NSDictionary *)item {
    
    self.label.text = item[@"text"];
    
    self.label.text = item[@"text"];
    
    self.label.top = 12;
    
    self.timelabel.text = item[@"time"];
    [self.timelabel sizeToFit];
}

@end

@interface XXXXViewController ()<ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *mainListView;
@end

@implementation XXXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"system logs";
    self.mainListView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
    self.mainListView.delegate = self;
    [self.view addSubview:self.mainListView];
    
    
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    NSMutableArray *ooo = [[NSMutableArray alloc] initWithArray:[Stack shared].gslogs];
    for (NSInteger i=ooo.count-1; i>0; i--) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:ooo[i]];
        NSString *text = [dic toJSONString];
        text = [text stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        CGFloat h = [text sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)].height;
        dic[@"item.size.height"] = @(h+10+12);
        dic[@"text"] = text;
        dic[@"native_id"] = @"xxxx";
        dic[@"time"] = [ABTime timestampToTime:dic[@"timestamp"] format:@"YYYY-MM-dd HH:mm:ss"];
        [dataList addObject:dic];
    }
    
    [self.mainListView setDataList:dataList css:@{@"item.rowSpacing":@"1"}];
    
}



- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mainListView.frame = self.view.bounds;
}

- (void)listView:(ABUIListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath item:(NSDictionary *)item {
    [[UIPasteboard generalPasteboard] setString:item[@"text"]];
    [ABUITips showError:@"已复制"];
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
