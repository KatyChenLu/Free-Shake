//
//  LeadViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "LeadViewController.h"
#import "PictureScanController.h"
#import "ReadingViewController.h"
#import "MemoryViewController.h"
#import "AudioViewController.h"

@interface LeadViewController ()

@end

@implementation LeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
// 摇一摇跳转界面
// 晃动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSArray *classArray = @[[PictureScanController class],[AudioViewController class],[ReadingViewController class],[MemoryViewController class]];
    NSInteger index = arc4random()%4;
    Class cls = classArray[index];
    SuperViewController *controller = [[cls alloc]init];
    controller.user = self.user;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
