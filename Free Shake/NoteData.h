//
//  NoteData.h
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTUtil.h"

@interface NoteData : NSObject

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *date_time;
@property (nonatomic) NSString *mood;

@end
