//
//  BaseNavigationController.m
//  zhibo
//
//  Created by FaiWong on 2020/4/22.
//  Copyright © 2020 qp. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
{
    UIImageView *navBarHairlineImageView;
    
}
@property (nonatomic, strong) UIView *navBarHairlineView;
@end

@implementation BaseNavigationController

//- (UIView *)navBarHairlineView
//{
//    if (!_navBarHairlineView) {
//        _navBarHairlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//        _navBarHairlineView.backgroundColor = [UIColor hexColor:@"cecece"];
//    }
//    return _navBarHairlineView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.delegate = self;
    //添加手势管理
    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.opaque = NO;
    self.navigationBar.translucent = NO;

    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    [navBarHairlineImageView addSubview:self.navBarHairlineView];
    
    self.navigationBar.translucent = false;
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    
    return nil;
    
}
/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
    
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme{
    //获取全局的 UINavigationBar
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.opaque = NO;
    appearance.translucent = NO;
    
    // 设置导航栏背景
//    [appearance setBarTintColor:[UIColor hexColor:@"ffffff"]];
    [appearance setTintColor:[UIColor redColor]];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [appearance setTitleTextAttributes:textAttrs];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor hexColor:@"303331"];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.viewControllers.count>=1) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 44)];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:@"baifanhui"] forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        
        [self updateNavStatus:viewController backButton:btn];
        
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
        viewController.navigationItem.leftBarButtonItem = bar;

    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    if (navigationController.viewControllers.count==1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }

}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self setNavigationBarHidden:viewController.isVisableNavigationBar == false animated:true];
}

- (void)updateNavStatus:(UIViewController *)vc backButton:(UIButton *)btn {
    if (vc.isVisableNavigationBar) {
        if (vc.preferredStatusBarStyle == UIStatusBarStyleLightContent) {
            [btn setImage:[UIImage imageNamed:@"baifanhui"] forState:UIControlStateNormal];
            self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blackColor};
        }
        else{
            [btn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
            self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blackColor};
        }
        
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
//    [self updateNavStatus:self.topViewController backButton:nil];
    return self.topViewController.preferredStatusBarStyle;
}

- (void)pop{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

