//
//  DrawView.m
//  PushLy
//
//  Created by ly on 16/3/28.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "PopView.h"
#define Duration 0.3
#define offset 20
#define delta (kMainScreenWidth-offset*2-43)/3

@interface PopView()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) UIButton *mainBtn;

@end

@implementation PopView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

//- (void)drawRect:(CGRect)rect {
//    CGContextRef ref = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(ref, 10, 10);
//    CGContextAddLineToPoint(ref, 50, 50);
//    CGContextStrokePath(ref);
//}
//构造函数
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self myAddViews];
    }
    return self;
}

-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

-(void)myAddViews{
    //设置第一个Button
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(offset, 3, 43, 43.5)];
    [btn setImage:[UIImage imageNamed:@"small_main_menu"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(mainBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.mainBtn = btn;
    
    [self addBtnWitnImageNamed:@"menu_btn_tixing" withTag:2];
    [self addBtnWitnImageNamed:@"menu_btn_cheyou" withTag:1];
    [self addBtnWitnImageNamed:@"menu_btn_call" withTag:0];
    
    [self myLayoutSubviews];
}

-(void)addBtnWitnImageNamed:(NSString *)imgName withTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    btn.tag = tag;
    [self.items addObject:btn];
    [self addSubview:btn];
}

//addSubView 时会触发，如果是纯代码实现的View就不需要layoutSubviews，会造成重复调用的问题
-(void)myLayoutSubviews{
    CGRect btnBounds = CGRectMake(0, 0, 43, 43.5);
    for (UIButton *btn in self.items) {
        btn.bounds = btnBounds;
        btn.center = self.mainBtn.center;
    }
    [self bringSubviewToFront:self.mainBtn];
}

//主按钮的点击事件
-(void)mainBtnClick{
    BOOL show = CGAffineTransformIsIdentity(self.mainBtn.transform);
    [UIView animateWithDuration:Duration animations:^{
        if (show) {
            self.mainBtn.transform = CGAffineTransformMakeRotation(M_PI_4);
        }else{
            self.mainBtn.transform = CGAffineTransformIdentity;
        }
    }];
    
    [self showItems:show];
}

/**
 *  显示其他按钮
 *
 *  @param show 主按钮是否显示状态
 */
-(void)showItems:(BOOL)show{
    for (UIButton *btn in self.items) {
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = Duration;
        // 2.2 添加一个 ”平移动画“
        CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animation];
        positionAni.keyPath = @"position";
        // 2.3 添加一个 ”旋转的动画“
        CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
        rotationAni.keyPath = @"transform.rotation";
        
        //重新设置每个按钮的x值
        CGFloat btnCenterX = self.mainBtn.center.x + (btn.tag + 1) * delta;
        CGFloat btnCenterY = self.mainBtn.center.y;
        
        // 最终显示的位置
        CGPoint showPosition = CGPointMake(btnCenterX, btnCenterY);
        
        //设置 "平移动画: 的 路径
        NSValue *value1 = [NSValue valueWithCGPoint:self.mainBtn.center];
        NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(btnCenterX * 0.5, btnCenterY)];
        NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(btnCenterX * 1.07, btnCenterY)];
        NSValue *value4 = [NSValue valueWithCGPoint:showPosition];
        positionAni.values = @[value1,value2,value3,value4];
        if (show) {
            //设置 旋转的路径
            rotationAni.values = @[@0,@(M_PI * 2),@(M_PI * 4),@(M_PI * 2)];
            
            btn.center = showPosition;
        }else{
            //设置 "平移动画: 的 路径
            positionAni.values = @[value4,value3,value2,value1];
            
            btn.center = self.mainBtn.center;
            rotationAni.values = @[@0,@(M_PI * 2),@(0),@(-M_PI * 2)];
        }
        //添加子动画
        group.animations = @[positionAni,rotationAni];
        //执行组动画
        [btn.layer addAnimation:group forKey:nil];
    }
}

@end
