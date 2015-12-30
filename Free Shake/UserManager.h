//
//  UserManager.h
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserManager : NSObject

+ (instancetype)sharedInstance;

- (void)add:(UserModel *)user;
- (void)update:(UserModel *)user;
- (UserModel *)fetchByName:(NSString *)name;
- (NSMutableArray *)fetchAll;

@end
