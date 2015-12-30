//
//  Util.m
//  Free Shake
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "RTUtil.h"

@implementation RTUtil

+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    /*
     第一个参数: 预设空间 宽度固定  高度预设 一个最大值
     第二个参数: 行间距 如果超出范围是否截断
     第三个参数: 属性字典 可以设置字体大小
    */
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    //返回计算出的行高
    return rect.size.height;
}
+ (NSString *)dateByFormatter:(NSString *)formatter{
    NSDate *date = [NSDate date];
    NSDateFormatter *sFormatter = [[NSDateFormatter alloc] init];
    sFormatter.dateFormat = formatter;
    NSString *str = [sFormatter stringFromDate:date];
    return str;
}
+ (UIImage *)getGradientImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType size:(CGSize)size{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case topToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case leftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case upleftTolowRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case uprightTolowLeft:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)getRandomGradientImageByGradientType:(GradientType)gradientType size:(CGSize)size{
    NSMutableArray *colorArray = [@[[UIColor colorWithRed:kRandom green:kRandom blue:kRandom alpha:1],[UIColor colorWithRed:kRandom green:kRandom blue:kRandom alpha:1]] mutableCopy];
    return [self getGradientImageFromColors:colorArray ByGradientType:gradientType size:size];
}

@end














