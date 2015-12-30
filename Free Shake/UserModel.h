//
//  UserModel.h
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageData.h"
#import "AudioData.h"
#import "NoteData.h"

@interface UserModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *email;

@end
