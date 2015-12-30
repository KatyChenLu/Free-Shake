//
//  PictureScanController.m
//  Free Shake
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "PictureScanController.h"
#import "ReadingViewController.h"
#import "MemoryViewController.h"
#import "AudioViewController.h"
#import "ResourceData.h"
#import "RTScrollView.h"
#import "RTUtil.h"

#define ViewWidth self.view.frame.size.width
#define ViewHeight self.view.frame.size.height
#define kHeight 120

@interface PictureScanController ()

@property (nonatomic) NSArray *classArray;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic) RTScrollView *scrollView;
@property (nonatomic) UILabel *contentLabel;

@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSMutableArray *selectedDataArray;
@property (nonatomic) NSMutableArray *selectedImageArray;

@property (nonatomic) NSInteger hour;
@property (nonatomic) NSInteger minute;
@property (nonatomic) NSInteger second;
@property (nonatomic) NSTimer *timer;



@end

@implementation PictureScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self initData];
    
    [self addScrollView];
    
    [self changeMainImageView];
    
}

//初始化数据
- (void)initData{
    self.dataArray = [ResourceData getImageByLocal];
    self.selectedDataArray = [NSMutableArray array];
    self.selectedImageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 7; i++) {
        NSInteger index = arc4random()%_dataArray.count;
        ImageData *data = _dataArray[index];
        [_selectedImageArray addObject:data.image];
        [_selectedDataArray addObject:data];
        [_dataArray removeObjectAtIndex:index];
        
    }
}
//添加底部索引视图scrollView
- (void)addScrollView{
    self.scrollView = [[RTScrollView alloc]initWithFrame:CGRectMake(0, ViewHeight-kHeight, self.view.frame.size.width, kHeight)];
    _scrollView.imageArray = self.selectedImageArray;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
}

//添加主图片视图
- (void)changeMainImageView{
    _mainImageView.image = _selectedImageArray[0];
    _titleLabel.text = ((ImageData *)_selectedDataArray[0]).title;

    self.contentLabel = [[UILabel alloc]init];
    _contentLabel.backgroundColor = [UIColor lightGrayColor];
    _contentLabel.alpha = 0.7f;
    _contentLabel.numberOfLines = 0;
    _contentLabel.text = ((ImageData *)_selectedDataArray[0]).content;
    _contentLabel.frame = [self getFrame];
    [self.mainImageView addSubview:_contentLabel];
    
    //将主视图与索引视图对应起来
    __block typeof(self) weakself = self;
    [_scrollView setPassValue:^(UIImage *image) {
        if (weakself.mainImageView.image == image) {
            return ;
        }
        CATransition *animation = [CATransition animation];
        [weakself animationEffect:animation animationType:@"pageCurl"];
        weakself.mainImageView.image = image;
        weakself.contentLabel.alpha = 0.7f;
        weakself.titleLabel.alpha = 0.7f;
        [[weakself.mainImageView layer] addAnimation:animation forKey:@"animation"];
        
        for (ImageData *data in weakself.selectedDataArray) {
            if (data.image == weakself.mainImageView.image) {
                weakself.titleLabel.text = data.title;
                weakself.contentLabel.text = data.content;
                weakself.contentLabel.frame = [weakself getFrame];
            }
        }
    }];
}
//根据_contentLabel的文本计算frame
- (CGRect)getFrame{
    CGFloat height = [RTUtil textHeightFromTextString:_contentLabel.text width:_mainImageView.frame.size.width fontSize:17];
    return CGRectMake(0, CGRectGetMaxY(_mainImageView.bounds)-height, _mainImageView.bounds.size.width, height);
}
//点击主视图效果
- (IBAction)tapOnMainImageView:(id)sender {
    CATransition *animation = [CATransition animation];
    [self animationEffect:animation animationType:@"rippleEffect"];
    if (self.contentLabel.alpha == 0.7f) {
        self.contentLabel.alpha =  0;
    }else{
        self.contentLabel.alpha = 0.7f;
    }
    [[_mainImageView layer] addAnimation:animation forKey:@"animation"];
}
//波纹动画
- (void)animationEffect:(CATransition *)animation animationType:(NSString *)animationType{
    animation.delegate = self;
    animation.duration = 1.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = animationType;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
// 摇一摇跳转界面
// 晃动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self removeAllViews];
    
    self.classArray = @[[AudioViewController class],[ReadingViewController class],[MemoryViewController class]];
    NSInteger index = arc4random()%3;
    Class cls = self.classArray[index];
    SuperViewController *controller = [[cls alloc]init];
    controller.user = self.user;
    [self.navigationController pushViewController:controller animated:YES];
}

@end


















