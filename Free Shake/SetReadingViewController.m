//
//  SetReadingViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "SetReadingViewController.h"

@interface SetReadingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *flagView;
@property (weak, nonatomic) IBOutlet UIButton *bgButton1;
@property (weak, nonatomic) IBOutlet UIButton *bgButton2;
@property (weak, nonatomic) IBOutlet UIButton *bgButton3;
@property (weak, nonatomic) IBOutlet UIButton *bgButton4;
@property (weak, nonatomic) IBOutlet UIButton *bgButton5;
@property (weak, nonatomic) IBOutlet UIButton *bgButton6;

@property (nonatomic) UIButton *lastButton;


@end

@implementation SetReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBg];
}
- (void)initBg{
    unichar ch = [self.selectedImageName characterAtIndex:3];
    NSString *str = [NSString stringWithFormat:@"%C",ch];
    NSInteger m = [str integerValue];
    NSArray *array = @[_bgButton1,_bgButton2,_bgButton3,_bgButton4,_bgButton5,_bgButton6];
    UIButton *button = array[m-1];
    [self chooseBGByImageName:_selectedImageName selectedButton:button];
}
- (IBAction)background1:(UIButton *)sender {
    [self chooseBGByImageName:@"bg_1" selectedButton:sender];
}
- (IBAction)background2:(UIButton *)sender {
    [self chooseBGByImageName:@"bg_2" selectedButton:sender];
}
- (IBAction)background3:(UIButton *)sender {
    [self chooseBGByImageName:@"bg_3" selectedButton:sender];
}
- (IBAction)background4:(UIButton *)sender {
    [self chooseBGByImageName:@"bg_4" selectedButton:sender];
}
- (IBAction)background5:(UIButton *)sender {
    [self chooseBGByImageName:@"bg_5" selectedButton:sender];
}
- (IBAction)background6:(UIButton *)sender {
    [self chooseBGByImageName:@"bg_6" selectedButton:sender];
}
//选择背景，使其进入选中状态
- (void)chooseBGByImageName:(NSString *)bgName selectedButton:(UIButton *)button{
    if (button == _lastButton) {
        return;
    }
    CGRect frame = button.frame;
    frame.size = self.flagView.frame.size;
    self.flagView.frame = frame;
    [self.view bringSubviewToFront:self.flagView];

    self.selectedImageName = bgName;
}
- (IBAction)sureToChooose:(id)sender {
    if (_passValueHandler) {
        _passValueHandler(_selectedImageName);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelChoose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end


















