//
//  RTScrollView.m
//  图片界面设计_2
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 Free_Shake. All rights reserved.
//

#import "RTScrollView.h"

#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height
#define kHeight 120

@interface RTScrollView ()<UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *firstImageView;
@property (nonatomic) UIImageView *secondImageView;
@property (nonatomic) UIImageView *centerImageView;
@property (nonatomic) UIImageView *fourthImageView;
@property (nonatomic) UIImageView *fifthImageView;

@property (nonatomic) NSInteger centerPage;

@end

@implementation RTScrollView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    [self setUp];
}
//配置_scrollView
- (void)setUp{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.delegate = self;
    //_scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor purpleColor];
    [_scrollView setContentSize:CGSizeMake(ViewWidth*5/3.0, kHeight)];
    
    [self addSubview:_scrollView];
    
    CGRect frame = self.bounds;
    frame.size.width = ViewWidth/3.0;
    
    self.firstImageView = [self setImageView:_firstImageView frame:frame];
    frame.origin.x += ViewWidth/3.0;
    self.secondImageView = [self setImageView:_secondImageView frame:frame];
    frame.origin.x += ViewWidth/3.0;
    self.centerImageView = [self setImageView:_centerImageView frame:frame];
    frame.origin.x += ViewWidth/3.0;
    self.fourthImageView = [self setImageView:_fourthImageView frame:frame];
    frame.origin.x += ViewWidth/3.0;
    self.fifthImageView = [self setImageView:_fifthImageView frame:frame];
    
    [_scrollView addSubview:self.firstImageView];
    [_scrollView addSubview:self.secondImageView];
    [_scrollView addSubview:self.centerImageView];
    [_scrollView addSubview:self.fourthImageView];
    [_scrollView addSubview:self.fifthImageView];
    
    self.centerPage = 0;
}
//设置_scrollView 上的 imageView
- (UIImageView *)setImageView:(UIImageView *)imageView frame:(CGRect)frame{
    imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.layer.borderWidth = 4.0;
    imageView.layer.borderColor = [[UIColor purpleColor]CGColor];
    imageView.layer.cornerRadius = 15;
    imageView.layer.masksToBounds = YES;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIndexImageView:)];
    [imageView addGestureRecognizer:tap];
    return imageView;
}
//点击索引视图
- (void)tapIndexImageView:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)[tap view];
   
    if (_getImage) {
        _getImage(imageView.image);
    }
}
- (void)setPassValue:(void (^)(UIImage *image))getImage{
    _getImage = getImage;
}
//设置索引视图显示
- (void)setCenterPage:(NSInteger)centerPage{
    _centerPage = centerPage;
    if (_centerPage < 0) {
        _centerPage = self.imageArray.count - 1;
    }
    if (_centerPage > self.imageArray.count - 1) {
        _centerPage = 0;
    }
    
    NSInteger secondPage = _centerPage - 1 < 0 ? self.imageArray.count-1 : _centerPage - 1;
    NSInteger firstPage = secondPage - 1 < 0 ? self.imageArray.count-1 : secondPage - 1;
    NSInteger fourthPage = _centerPage + 1 > self.imageArray.count - 1 ? 0 : _centerPage + 1;
    NSInteger fifthPage = fourthPage + 1 > self.imageArray.count - 1 ? 0 : fourthPage + 1;
    
    self.firstImageView.image = self.imageArray[firstPage];
    self.secondImageView.image = self.imageArray[secondPage];
    self.centerImageView.image = self.imageArray[_centerPage];
    self.fourthImageView.image = self.imageArray[fourthPage];
    self.fifthImageView.image = self.imageArray[fifthPage];
    
    [self.scrollView setContentOffset:CGPointMake(ViewWidth/3.0, 0)];
    
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > ViewWidth/6.0) {
        self.centerPage++;
    } else if (scrollView.contentOffset.x < ViewWidth/6.0) {
        self.centerPage--;
    }
}


@end




















