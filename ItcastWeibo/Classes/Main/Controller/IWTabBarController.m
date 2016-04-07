//
//  IWTabBarController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/4.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWTabBarController.h"

#import "IWHomeViewController.h"
#import "IWMessageViewController.h"
#import "IWDiscoverViewController.h"
#import "IWProfileViewController.h"
#import "IWNavViewController.h"

#import "IWTabBar.h"

#import "IWUserUnreadResult.h"
#import "IWUserTool.h"

#import "IWComposeViewController.h"
#import "UIView+Frame.h"

#import "TPCSpringMenu.h"



@interface IWTabBarController ()<IWTabBarDelegate, TPCSpringMenuDataSource, TPCSpringMenuDelegate>

@property (nonatomic, weak) IWTabBar *customTabBar;

@property (nonatomic, strong) IWHomeViewController *home;
@property (nonatomic, strong) IWMessageViewController *message;
@property (nonatomic, strong) IWProfileViewController *profile;

@property (nonatomic, assign) NSInteger selIndex;

@property (weak, nonatomic) TPCSpringMenu *menu;
@end

@implementation IWTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.自定义tabBar
    [self setUpTabBar];
    
    // 2.添加子控制器
    [self setUpAllChildViewController];
    
    // 3.获取用户未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //创建弹出menu
    [self initSpringMenu];
    
    
}
- (void)getUnreadCount
{
    [IWUserTool unreadCountDidsuccess:^(IWUserUnreadResult *unreadResult) {
        
        // 设置首页提醒
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadResult.status];
        
        // 设置消息提醒
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadResult.messageCount];
        
        // 设置我提醒
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadResult.follower];
        
        // 设置application提醒数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = unreadResult.totalCount;
        
    } failure:^(NSError *error) {
        
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    
//    // 删除系统自带的tabBarButton
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if (![tabBarButton isKindOfClass:[IWTabBar class]]) {
//            [tabBarButton removeFromSuperview];
//        }
//    }
}

-(UIVisualEffectView *)origenBackground:(CGRect)rect withStyle:(UIBlurEffectStyle)style{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    if (rect.size.height == self.tabBar.height) {//在tabbar的背景上加一条线
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 0.5)];
        view.backgroundColor = IWColor(222, 222, 222);
        [effectview addSubview:view];
    }
    effectview.frame = rect;
    return effectview;
}

// 设置tabBar
- (void)setUpTabBar
{
    IWTabBar *tabBar = [[IWTabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    
    [tabBar addSubview:[self origenBackground:self.tabBar.bounds withStyle:UIBlurEffectStyleExtraLight]];
    tabBar.delegate = self;
    
    [self.tabBar addSubview:tabBar];
    
    _customTabBar = tabBar;
    
}

// 添加所有子控制器
- (void)setUpAllChildViewController
{
    // 首页
    IWHomeViewController *home = [[IWHomeViewController alloc] init];
    [self setUpOneChildViewController:home title:@"首页" imageName:@"tabbar_home" selImageName:@"tabbar_home_selected"];
    _home = home;
    
    // 消息
    IWMessageViewController *message = [[IWMessageViewController alloc] init];
    [self setUpOneChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selImageName:@"tabbar_message_center_selected"];
    _message = message;

    // 广场
    IWDiscoverViewController *discover = [[IWDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover title:@"发现" imageName:@"tabbar_discover" selImageName:@"tabbar_discover_selected"];
    
    
    // 我
    IWProfileViewController *profile = [[IWProfileViewController alloc] init];
    [self setUpOneChildViewController:profile title:@"我" imageName:@"tabbar_profile" selImageName:@"tabbar_profile_selected"];
    _profile = profile;
}

// 添加一个控制器的属性
- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selImageName:(NSString *)selImageName
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selImage = [UIImage imageNamed:selImageName];
    if (iOS7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    vc.tabBarItem.selectedImage = selImage;
    
    IWNavViewController *nav = [[IWNavViewController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];

}

// IWTabBar代理方法
- (void)tabBar:(IWTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex == 0 && selectedIndex == _selIndex ) { // 点击首页 刷新首页
        // 刷新数据
        [_home refresh];
    }
    
    self.selectedIndex = selectedIndex;
    
    _selIndex = selectedIndex;
}



- (void)tabBarDidClickAddBtn:(IWTabBar *)tabBar
{
//    IWComposeViewController *compose = [[IWComposeViewController alloc] init];
//    
//    IWNavViewController *nav = [[IWNavViewController alloc] initWithRootViewController:compose];
//    [self presentViewController:nav animated:YES completion:nil];
    [self.menu becomeActive];
}

-(void)initSpringMenu{
    TPCItem *item1 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_idea"] title:@"文字"];
    TPCItem *item2 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_photo"] title:@"照片/视频"];
    
    TPCItem *item3 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_headlines"] title:@"头条文章"];
    TPCItem *item4 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_lbs"] title:@"签到"];
    
    TPCItem *item5 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_review"] title:@"点评"];
    TPCItem *item6 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_more"] title:@"更多"];
    NSArray *items = @[item1, item2, item3, item4, item5, item6];
    
    
    TPCSpringMenu *menu = [TPCSpringMenu menuWithItems:items];
    // 按钮文字颜色
    menu.buttonTitleColor = [UIColor blackColor];
    // 按钮行数
    menu.columns = 3;
    // 最后一个按钮与底部的距离
    menu.spaceToBottom = 150;
    // 按钮半径（只支持圆形图片，非圆形图片以宽度算）
    menu.buttonDiameter = 71;
    // 允许点击隐藏menu
    menu.enableTouchResignActive = YES;
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    _menu = menu;
}

#pragma mark TPCSpringMenuDataSource
- (UIButton *)buttonToChangeActiveForSpringMenu:(TPCSpringMenu *)menu
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, self.view.bounds.size.width, 49);
    btn.backgroundColor  = [UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    
    return btn;
}

- (UIView *)backgroundViewOfSpringMenu:(TPCSpringMenu *)menu
{
    UIView *view = [self origenBackground:self.view.bounds withStyle:UIBlurEffectStyleLight];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
    imageView.bounds = CGRectMake(0, 20, 154, 48);
    imageView.center = CGPointMake(self.view.bounds.size.width * 0.5, 100);
    [view addSubview:imageView];
    return view;
}

@end
