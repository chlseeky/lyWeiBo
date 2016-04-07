//
//  CarouselView.h
//  PushLy
//
//  Created by ly on 16/3/30.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UIView

@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIScrollView *scrollView;
//@property (nonatomic,weak)NSTimer *timer;

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count;

-(void)carouselDisplay;

@end
