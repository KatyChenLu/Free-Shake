//
//  ImageData.h
//  Free Shake
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageData : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;

@end
