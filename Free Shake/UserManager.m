//
//  UserManager.m
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "UserManager.h"
#import "FMDatabase.h"

#define kTableName @"UserList"

@interface UserManager ()

@property (nonatomic) FMDatabase *dataBase;

@end

@implementation UserManager

- (void)add:(UserModel *)user{
    if ([self.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"insert into %@ values(?,?,?)", kTableName];
        if ([self.dataBase executeUpdate:sql, user.name, user.password, user.email]) {
            NSLog(@"增加用户对象成功");
        }
        [self.dataBase close];
    }
}
- (void)update:(UserModel *)user{
    NSString *sql = [NSString stringWithFormat:@"update %@ set password=?, email=? where name=?", kTableName];
    if ([self.dataBase open]) {
        if ([self.dataBase executeUpdate:sql, user.password, user.email, user.name]) {
            NSLog(@"更改一条用户记录成功");
        }
        [self.dataBase close];
    }
}
- (UserModel *)fetchByName:(NSString *)name{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where name=?", kTableName];
    if ([self.dataBase open]) {
        FMResultSet *set = [self.dataBase executeQuery:sql, name];
        UserModel *user = nil;
        if ([set next]) {
            user = [[UserModel alloc] init];
            user.name = [set stringForColumn:@"name"];
            user.password = [set stringForColumn:@"password"];
            user.email = [set stringForColumn:@"email"];
        }
        [self.dataBase close];
        return user;
    }
    return nil;

}
- (NSMutableArray *)fetchAll{
    NSString *sql = [NSString stringWithFormat:@"select * from %@", kTableName];
    if ([self.dataBase open]) {
        FMResultSet *set = [self.dataBase executeQuery:sql];
        NSMutableArray *userArray = [NSMutableArray array];
        while ([set next]) { 
            UserModel *user = [[UserModel alloc]init];
            user.name = [set stringForColumn:@"name"];
            user.password = [set stringForColumn:@"password"];
            user.email = [set stringForColumn:@"email"];
            [userArray addObject:user];
        }
        [self.dataBase close];
        return userArray;
    }
    return nil;
}
- (instancetype)init {
    if (self = [super init]) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"UserList.db"];
        NSLog(@"%@", dbPath);
        self.dataBase = [[FMDatabase alloc] initWithPath:dbPath];
        if ([_dataBase open]) {
            NSLog(@"打开数据库成功");
            NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(name text primary key, password text, email text)", kTableName];
            if ([self.dataBase executeUpdate:sql]) {
                NSLog(@"创建表格成功");
            }
            [self.dataBase close];
        }
    }
    return self;
}

+ (instancetype)sharedInstance {
    static UserManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[UserManager alloc] init];
    });
    return manager;
}


@end
