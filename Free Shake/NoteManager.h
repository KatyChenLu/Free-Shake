//
//  NoteManager.h
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteData.h"

@interface NoteManager : NSObject

+ (instancetype)sharedInstance;

- (void)add:(NoteData *)note;
- (void)delete:(NoteData *)note;
- (void)deleteByDateAndTime:(NSString *)date_time;
- (NSMutableArray *)fetchNoteListByUserName:(NSString *)userName;

@end
