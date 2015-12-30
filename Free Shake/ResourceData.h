//
//  ResourceData.h
//  Free Shake
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageData.h"
#import "ArticleData.h"
#import "AudioData.h"

@interface ResourceData : NSObject

+ (NSMutableArray *)getImageByUrl:(NSURL *)url;
+ (NSMutableArray *)getImageByLocal;

+ (AudioData *)getAudioByUrl:(NSURL *)url;
+ (AudioData *)getAudioByLocal;

+ (ArticleData *)getArticleByLocal;
+ (ArticleData *)getArticleByUrl:(NSURL *)url;

@end
