//
//  UIImage+Resizable.h
//  ItcastWeibo
//
//  Created by yz on 14/11/5.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resizable)

+ (instancetype)resizableWithImageName:(NSString *)imageName;
/**
 *  拉伸图片
 *
 *  @param imgName 图片
 *
 *  @return UIImage
 */
+ (UIImage *)reSizeImage:(NSString *)imgName;

/**
 *  拉伸图片
 *
 *  @param imgName 图片
 *  @param reSize  目的尺寸
 *
 *  @return UIImage
 */
+ (UIImage *)reSizeImage:(NSString *)imgName toSize:(CGSize)reSize;

/**
 *
 *  @param bgImageName    背景图片
 *  @param waterImageName 水印图片
 *  @param scale 图片生成的比例
 *  @return 添加了水印的背景图片
 */
+(UIImage *)waterImageWithBgImageName:(NSString *)bgImageName waterImageName:(NSString *)waterImageName scale:(CGFloat)scale;


/**
 *
 *  @param imageName    需要裁剪的图片
 *  @param borderColor 边框的颜色
 *  @param borderWidth 边框的宽度
 *  @return 一个裁剪 带有边框的圆形图片
 */
+(UIImage *)circleImageWithImageName:(NSString *)imageName borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

+(UIImage *)circleImageWithImage:(UIImage *)img borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
/**
 *  截屏
 *
 *  @param size  要截屏的宽高
 *  @param layer 在哪个图层上截屏
 *
 *  @return 得到的图片
 */
-(UIImage *)screenPhotoWithRect:(CGSize)size Layer:(CALayer  *)layer;
@end
