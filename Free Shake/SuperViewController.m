//
//  SuperViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@property (nonatomic) NSArray *classArray;

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)removeAllViews{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}



@end
