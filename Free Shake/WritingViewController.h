//
//  WritingViewController.h
//  Free Shake
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "NoteManager.h"

typedef void (^PassValueHandler)(NoteData *note) ;

@interface WritingViewController : UIViewController

@property (nonatomic) UserModel *user;
@property (nonatomic,copy) PassValueHandler passValueHandler;

- (void)setPassValueHandler:(PassValueHandler)passValueHandler;

@end
