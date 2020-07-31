//
//  UITabBarController+Extension.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "UITabBarController+Extension.h"
@implementation UITabBarController (Extension)
- (void)setUpChildsFromConfig:(NSDictionary *)config {
    NSArray *list = config[@"data"];
    for (NSDictionary *item in list) {
        
        //parse data from item
        NSString *module = item[@"module"];
        NSString *title = item[@"title"];
        NSString *nmIconName = item[@"icon"];
        NSString *hlIconName = item[@"icon_h"];
        NSDictionary *navDic = item[@"nav"];
        
        //dynmic load vc from module name
        UIViewController *vc = [[NSClassFromString(module) alloc] init];
        vc.title = title;
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
        //create image from image name
        UIImage *nmImage = [[UIImage imageNamed:nmIconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *hlImage = [[UIImage imageNamed:hlIconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nmImage selectedImage:hlImage];
        nav.tabBarItem = tabBarItem;
        
        
        [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:@"FF2828"]] forBarMetrics:UIBarMetricsDefault];
        
//        if (navDic != nil) {
//            NSMutableArray *colors = [[NSMutableArray alloc] init];
//            NSArray *bgcolors = navDic[@"bgcolors"];
//            for (NSString *colorhex in bgcolors) {
//                [colors addObject:(__bridge id)[UIColor hexColor:colorhex].CGColor];
//            }
//            [nav.navigationBar setBackgroundImage:[UIImage imageWithGradientColors:colors frame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT)] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
//        }else{
//            [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:@"f3f3f2"] frame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT)] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
//        }
        
        //append to childs
        [self addChildViewController:nav];
    }
}
@end
