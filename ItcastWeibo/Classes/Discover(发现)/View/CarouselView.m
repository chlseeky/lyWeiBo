//
//  CarouselView.m
//  PushLy
//
//  Created by ly on 16/3/30.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "CarouselView.h"
#define SelfWidth self.frame.size.width
#define SelfHeignt self.frame.size.height

@interface CarouselView()

@property (nonatomic, assign)NSInteger count;
@end

@implementation CarouselView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count{
    self.count = count;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SelfWidth, SelfHeignt)];
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SelfWidth*self.count, SelfHeignt);
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((SelfWidth-100)/2, SelfHeignt-30, 100, 20)];
        _pageControl.numberOfPages = self.count;
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    }
    return _pageControl;
}

-(void)initSubViews{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    for (int i = 0; i < self.count; i++) {
        [self addImgView:[NSString stringWithFormat:@"img_0%d",i+1] position:i];
    }
}

-(void)addImgView:(NSString *)imgName position:(NSInteger)position{
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(position*SelfWidth, 0, SelfWidth, SelfHeignt)];
    [view setImage:[UIImage imageNamed:imgName]];
    [self.scrollView addSubview:view];
}

-(void)carouselDisplay{
    //当前页码
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages - 1) {
        page = 0;
    }else{
        page++;
    }
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
}

@end
