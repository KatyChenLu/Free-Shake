//
//  ReadingViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "PictureScanController.h"
#import "MemoryViewController.h"
#import "AudioViewController.h"
#import "ReadingViewController.h"
#import "SetReadingViewController.h"
#import "CommentReadingViewController.h"
#import "ResourceData.h"

@interface ReadingViewController ()

@property (nonatomic) NSArray *classArray;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentVIew;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (nonatomic,copy) NSMutableString *bgName;

@end

@implementation ReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}
- (NSMutableString *)bgName{
    if (_bgName == nil) {
        _bgName = [[NSMutableString alloc]initWithString:@"bg_1"];
    }
    return _bgName;
}
//刷新页面数据
- (void)setUp{
    ArticleData *article = [[ArticleData alloc]init];
    article = [ResourceData getArticleByLocal];
    self.titleLabel.text = article.title;
    self.authorLabel.text = article.author;
    self.contentVIew.text = article.content;
}
//收藏
- (IBAction)collect:(UIButton *)sender {
    self.collectLabel.text = @"已收藏";
    [sender setBackgroundImage:[UIImage imageNamed:@"collected"] forState:UIControlStateNormal];
    sender.enabled = NO;
}
- (IBAction)comment:(id)sender {
}
//赞
- (IBAction)zan:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"zan_2"] forState:UIControlStateNormal];
    self.zanLabel.text = @"已赞";
    sender.enabled = NO;
}
//进入设置界面
- (IBAction)setting:(id)sender {
    SetReadingViewController *controller = [[SetReadingViewController alloc]init];
    [controller setPassValueHandler:^(NSString *bgName) {
        self.bgImageView.image = [UIImage imageNamed:bgName];
        self.bgName = [NSMutableString stringWithString:bgName];
    }];
    controller.selectedImageName = self.bgName;
    [self presentViewController:controller animated:YES completion:nil];
}
// 摇一摇跳转界面
// 晃动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self removeAllViews];
    
    self.classArray = @[[PictureScanController class],[AudioViewController class],[MemoryViewController class]];
    NSInteger index = arc4random()%3;
    Class cls = self.classArray[index];
    SuperViewController *controller = [[cls alloc]init];
    controller.user = self.user;
    [self.navigationController pushViewController:controller animated:YES];
}

@end























