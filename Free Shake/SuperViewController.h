//
//  SuperViewController.h
//  Free Shake
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"

@interface SuperViewController : UIViewController

@property (nonatomic) UserModel *user;

- (void)removeAllViews;

@end
