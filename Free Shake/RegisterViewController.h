//
//  RegisterViewController.h
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"

@interface RegisterViewController : UIViewController
{
    void(^_block)(UserModel *);
}

@property (nonatomic) UserModel *user;

- (void)setPassValue:(void(^)(UserModel *user))block;

@end
