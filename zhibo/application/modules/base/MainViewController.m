//
//  MainViewController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "MainViewController.h"
#import "UITabBarController+Extension.h"
#import "ZBTabBar.h"
#import "PopUpOptionsView.h"
@interface MainViewController ()<ZBTabbarDelegate>
@property (nonatomic, strong) ZBTabBar *zbTabBar;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configTabBar];
    
    [self setUpChildsFromConfig:[ResourceUtil tabData]];
    
    [self fetchPostUri:URI_ROOM_GIFT params:nil];
}

- (void)configTabBar{
    self.zbTabBar = [ZBTabBar new];
    self.zbTabBar.delegatee = self;
    [self setValue:self.zbTabBar forKey:@"tabBar"];
    
    if (@available(iOS 13.0, *)) {
//        UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
//        tabBarAppearance.backgroundImage = [UIImage imageWithColor:UIColor.clearColor];
//        tabBarAppearance.shadowImage = [UIImage imageWithColor:UIColor.clearColor];
//        self.tabBar.standardAppearance = tabBarAppearance;
        
        self.tabBar.standardAppearance.backgroundImage = [UIImage imageWithColor:UIColor.whiteColor];
        self.tabBar.standardAppearance.shadowImage = [UIImage imageWithColor:UIColor.whiteColor];
        self.tabBar.unselectedItemTintColor = [UIColor hexColor:@"C5C7D3"];
    } else {
        [UITabBar appearance].backgroundImage = [UIImage new];
        [UITabBar appearance].shadowImage = [UIImage new];
    }


    [UITabBar appearance].backgroundColor = UIColor.whiteColor;
    [UITabBar appearance].tintColor = [UIColor hexColor:@"#00BFCB"];

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"#C5C7D3"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hexColor:@"#00BFCB"]} forState:UIControlStateSelected];

    self.tabBar.translucent = false;
    self.tabBar.layer.shadowColor = [[UIColor hexColor:@"3A4C82"] CGColor];
    self.tabBar.layer.shadowOpacity = 0.07;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -19);
    self.tabBar.layer.shadowRadius = 38;
}


- (void)onCenterButtonAction {
    [NSRouter gotoKaibo];
//    PopUpOptionsView *v = [[PopUpOptionsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 211+TI_HEIGHT)];
//    [[PopUp shared] show:v from:PopUpDirectionBottom];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [tabBar.items indexOfObject:item];
    
    if (index == 2) {
        
    }
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
