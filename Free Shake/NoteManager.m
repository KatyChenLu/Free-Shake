//
//  NoteManager.m
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "NoteManager.h"
#import "FMDatabase.h"

#define kTableName @"NoteList"

@interface NoteManager ()

@property (nonatomic) FMDatabase *dataBase;

@end

@implementation NoteManager

- (void)add:(NoteData *)note{
    if ([self.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"insert into %@ values(?,?,?,?,?,?,?)", kTableName];
        if ([self.dataBase executeUpdate:sql, note.userName, note.title, note.content,note.date_time,note.date,note.time,note.mood]) {
            NSLog(@"增加Note对象成功");
        }
        [self.dataBase close];
    }
}
- (void)delete:(NoteData *)note {
    [self deleteByDateAndTime:note.date_time];
}
- (void)deleteByDateAndTime:(NSString *)date_time {
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where date_time=?", kTableName];
    if ([self.dataBase open]) {
        if ([self.dataBase executeUpdate:sql, date_time]) {
            NSLog(@"删除一条记录成功");
        }
        [self.dataBase close];
    }
}
- (NSMutableArray *)fetchNoteListByUserName:(NSString *)userName{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where userName=?", kTableName];
    if ([self.dataBase open]) {
        FMResultSet *set = [self.dataBase executeQuery:sql,userName];
        NSMutableArray *noteArray = [NSMutableArray array];
        while ([set next]) {
            NoteData *note = [[NoteData alloc]init];
            note.userName = [set stringForColumn:@"userName"];
            note.title = [set stringForColumn:@"title"];
            note.content = [set stringForColumn:@"content"];
            note.date_time = [set stringForColumn:@"date_time"];
            note.date = [set stringForColumn:@"date"];
            note.time = [set stringForColumn:@"time"];
            note.mood = [set stringForColumn:@"mood"];
            [noteArray addObject:note];
        }
        [self.dataBase close];
        return noteArray;
    }
    return nil;
}
- (instancetype)init {
    if (self = [super init]) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"NoteList.db"];
        NSLog(@"%@", dbPath);
        self.dataBase = [[FMDatabase alloc] initWithPath:dbPath];
        if ([_dataBase open]) {
            NSLog(@"打开数据库成功");
            NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(userName text , title text, content text, date_time text primary key,date text,time text,mood text)", kTableName];
            if ([self.dataBase executeUpdate:sql]) {
                NSLog(@"创建表格成功");
            }
            [self.dataBase close];
        }
    }
    return self;
}

+ (instancetype)sharedInstance {
    static NoteManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[NoteManager alloc] init];
    });
    return manager;
}


@end
