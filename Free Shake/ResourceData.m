//
//  ResourceData.m
//  Free Shake
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "ResourceData.h"

@implementation ResourceData

//获取图片资源
+ (NSMutableArray *)getImageByUrl:(NSURL *)url{
    return nil;
}
+ (NSMutableArray *)getImageByLocal{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"imageResource" ofType:@"plist"];
    NSDictionary *resourceDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    for (NSInteger i = 0; i < [resourceDict allKeys].count; i++) {
        ImageData *data = [[ImageData alloc]init];
        NSString *key = [NSString stringWithFormat:@"item%ld",i];
        NSDictionary *itemDict = [resourceDict objectForKey:key];
        NSString *name = itemDict[@"image"];
        data.title = itemDict[@"title"];
        data.content = itemDict[@"content"];
        data.image = [UIImage imageNamed:name];
        [dataArray addObject:data];
    }
    return dataArray;
}
//获取音频资源
+ (AudioData *)getAudioByUrl:(NSURL *)url{
    return nil;
}
+ (AudioData *)getAudioByLocal{
    NSArray *array = @[@"蜀绣",@"白月光",@"春天花会开",@"大约在冬季",@"单身情歌",@"红豆",@"十七岁的雨季",@"谢谢你的爱1999",@"夜太黑",@"阴天"];
    NSInteger index = arc4random()%10;
    AudioData *audio = [[AudioData alloc]init];
    audio.name = array[index];
    return audio;
}
+ (ArticleData *)getArticleByLocal{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"essay" ofType:@"plist"];
    NSDictionary *resourceDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSInteger index = arc4random()%10;
    NSDictionary *dict = [[NSDictionary alloc]init];
    NSString *key = [NSString stringWithFormat:@"item%ld",index];
    dict = [resourceDict objectForKey:key];
    ArticleData *article = [[ArticleData alloc]init];
    article.title = dict[@"title"];
    article.author = dict[@"author"];
    article.content = dict[@"content"];
    return article;
}
+ (ArticleData *)getArticleByUrl:(NSURL *)url{
    return nil;
}


@end
