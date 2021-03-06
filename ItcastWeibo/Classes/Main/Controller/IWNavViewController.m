//
//  IWNavViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWNavViewController.h"
#import "IWTabBar.h"
@interface IWNavViewController ()<UINavigationControllerDelegate>

@end

@implementation IWNavViewController

// 这个方法调用：第一次使用本类或者他的子类会调用
+ (void)initialize
{
    if (self == [IWNavViewController class]) {
        // 设置导航条的标题
        [self setUpNavBarTitle];
        
        // 设置导航条的按钮
        [self setUpNavBarButton];
    }
}

+ (void)setUpNavBarButton
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置不可用状态下的按钮颜色
    NSMutableDictionary *disableDictM = [NSMutableDictionary dictionary];
    disableDictM[NSForegroundColorAttributeName] = IWColor(100, 100, 100);
    disableDictM[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:disableDictM forState:UIControlStateDisabled];

    NSMutableDictionary *normalDictM = [NSMutableDictionary dictionary];
    normalDictM[NSForegroundColorAttributeName] = IWColor(100, 100, 100);
    normalDictM[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    // 设置普通状态下的按钮颜色
    [item setTitleTextAttributes:normalDictM forState:UIControlStateNormal];
}

// 设置导航条的标题
+ (void)setUpNavBarTitle
{
    
    UINavigationBar *nav = [UINavigationBar appearanceWhenContainedIn:[IWNavViewController class], nil];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = IWNavgationBarTitleFont;
    [nav setTitleTextAttributes:dictM];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = nil;
//    NSLog(@"%@",self.interactivePopGestureRecognizer.delegate);
    
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;

        // 设置导航条的按钮 navigationbar_back_withtext  navigationbar_back_withtext_highlighted
        UIBarButtonItem *popPre = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_back_withtext" highImage:@"navigationbar_back_withtext_highlighted" target:self action:@selector(popToPre) title:@"我"];
        viewController.navigationItem.leftBarButtonItem = popPre;
        
        UIBarButtonItem *popRoot = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_more" highImage:@"navigationbar_more_highlighted" target:self action:@selector(popToRoot) title:nil];
        viewController.navigationItem.rightBarButtonItem = popRoot;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;

    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[IWTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
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
