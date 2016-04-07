//
//  IWDiscoverViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/4.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWDiscoverViewController.h"
#import "IWSearchBar.h"
#import "CarouselView.h"

@interface IWDiscoverViewController ()<UITextFieldDelegate,IWSearchBarDelegate,UIScrollViewDelegate>

@property (nonatomic)IWSearchBar *searchBar;
@property (nonatomic,strong)CarouselView *carouselView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation IWDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航条内容
    [self setUpNavBar];
    
    //1.添加图片轮播
//    self.carouselView=[[CarouselView alloc]initWithFrame:CGRectMake(0, 64+10, kMainScreenWidth, 110) count:2];
//    self.carouselView.scrollView.delegate = self;
//    [self.view addSubview:[[UIButton alloc]init]];
//    [self.view addSubview: self.carouselView];
//    [self addTimer];

}

- (void)setUpNavBar
{
    // 搜索框
    self.searchBar = [[IWSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 32)];
    self.searchBar.field.delegate = self;
    self.searchBar.aDelegate = self;
    self.navigationItem.titleView = self.searchBar;
    
}

-(void)cancelBtnClick{
    [self.view endEditing:YES];
    [self.searchBar.field resignFirstResponder];
    [self.searchBar showOthers:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.searchBar showOthers:YES];
    return YES;
}


#pragma mark 下面是图片轮播的代码
- (void)addTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer = timer;
    //消息循环
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)nextImage{
    [self.carouselView carouselDisplay];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2)/ scrollView.frame.size.width;
    self.carouselView.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止定时器
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

@end
