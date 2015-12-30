//
//  SetReadingViewController.h
//  Free Shake
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PassValueHandler)(NSString *bgName) ;

@interface SetReadingViewController : UIViewController

@property (nonatomic,copy) NSString *selectedImageName;
@property (nonatomic,copy) PassValueHandler passValueHandler;

- (void)setPassValueHandler:(PassValueHandler)passValueHandler;

@end
