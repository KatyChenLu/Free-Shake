//
//  Util.h
//  Free Shake
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kRandom  arc4random()%255/256.0

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight ,//从左到右
    upleftTolowRight ,//左上到右下
    uprightTolowLeft ,//右上到左下
}GradientType;

@interface RTUtil : NSObject

//计算Label文本高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;
//根据格式获取时间字符串
+ (NSString *)dateByFormatter:(NSString *)formatter;
//获取一张渐变色图片
+ (UIImage *)getGradientImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType size:(CGSize)size;
+ (UIImage *)getRandomGradientImageByGradientType:(GradientType)gradientType size:(CGSize)size;

@end
