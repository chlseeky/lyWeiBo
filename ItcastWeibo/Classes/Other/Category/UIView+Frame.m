//
//  UIView+Frame.m
//  ItcastWeibo
//
//  Created by yz on 14/11/5.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//
// This code for synthesizing touch events is derived from:
// http://cocoawithlove.com/2008/10/synthesizing-touch-event-on-iphone.html

#import "UIView+Frame.h"

@interface GSEventFake : NSObject {
@public
    int ignored1[5];
    float x;
    float y;
    int ignored2[24];
}
@end

@implementation GSEventFake
@end

@interface UIEventFake : NSObject {
@public
    CFTypeRef _event;
    NSTimeInterval _timestamp;
    NSMutableSet* _touches;
    CFMutableDictionaryRef _keyedTouches;
}
@end

@implementation UIEventFake
@end

@interface UITouch (TTCategory)

- (id)initInView:(UIView *)view location:(CGPoint)location;
- (void)changeToPhase:(UITouchPhase)phase;

@end

@implementation UITouch (TTCategory)

- (id)initInView:(UIView *)view location:(CGPoint)location
{
    if (self = [super init])
    {
    }
    return self;
}

- (void)changeToPhase:(UITouchPhase)phase {
    
}

@end

@implementation UIEvent (TTCategory)

- (id)initWithTouch:(UITouch *)touch {
    if (self == [super init]) {
        UIEventFake *selfFake = (UIEventFake*)self;
        selfFake->_touches = [NSMutableSet setWithObject:touch];
        selfFake->_timestamp = [NSDate timeIntervalSinceReferenceDate];
        
        CGPoint location = [touch locationInView:touch.window];
        GSEventFake* fakeGSEvent = [[GSEventFake alloc] init];
        fakeGSEvent->x = location.x;
        fakeGSEvent->y = location.y;
        selfFake->_event = (__bridge CFTypeRef)(fakeGSEvent);
        
        CFMutableDictionaryRef dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 2,
                                                                &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        CFDictionaryAddValue(dict, (__bridge const void *)(touch.view), (__bridge const void *)(selfFake->_touches));
        CFDictionaryAddValue(dict, (__bridge const void *)(touch.window), (__bridge const void *)(selfFake->_touches));
        selfFake->_keyedTouches = dict;
    }
    return self;
}

@end

@implementation UIView (Frame)

- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;

}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;

}


- (CGSize)size
{
    return self.frame.size;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGFloat)screenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

//- (CGFloat)orientationWidth {
//  //return UIDeviceOrientationIsLandscape(TTDeviceOrientation())
//    //? self.height : self.width;
//}
//
//- (CGFloat)orientationHeight {
//  //return UIDeviceOrientationIsLandscape(TTDeviceOrientation())
//    //? self.width : self.height;
//}

- (UIScrollView*)findFirstScrollView {
    if ([self isKindOfClass:[UIScrollView class]])
        return (UIScrollView*)self;
    
    for (UIView* child in self.subviews) {
        UIScrollView* it = [child findFirstScrollView];
        if (it)
            return it;
    }
    
    return nil;
}

- (UIView*)firstViewOfClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child firstViewOfClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (UIView*)firstParentOfClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview firstParentOfClass:cls];
    } else {
        return nil;
    }
}

- (UIView*)findChildWithDescendant:(UIView*)descendant {
    for (UIView* view = descendant; view && view != self; view = view.superview) {
        if (view.superview == self) {
            return view;
        }
    }
    
    return nil;
}

- (void)removeSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)simulateTapAtPoint:(CGPoint)location {
    UITouch *touch = [[UITouch alloc] initInView:self location:location];
    
    UIEvent *eventDown = [[UIEvent alloc] initWithTouch:touch];
    [touch.view touchesBegan:[NSSet setWithObject:touch] withEvent:eventDown];
    
    [touch changeToPhase:UITouchPhaseEnded];
    
    UIEvent *eventUp = [[UIEvent alloc] initWithTouch:touch];
    [touch.view touchesEnded:[NSSet setWithObject:touch] withEvent:eventUp];
}
- (UIImage *)screenshotMH{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)viewAddBottomLine
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, self.width, 0.5)];
    line.backgroundColor = IWColor(229, 229, 229);
    [self addSubview:line];
}
- (UIView *)getViewLine:(CGRect)aRect
{
    UIView *line = [[UIView alloc] initWithFrame:aRect];
    line.backgroundColor = IWColor(229, 229, 229);
    return line;
}

@end
