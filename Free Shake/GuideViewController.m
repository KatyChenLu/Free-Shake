//
//  GuideViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "GuideViewController.h"
#import "LoginViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollView];
    
    [self addPageControl];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)addScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width*5.0, self.view.frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    CGRect frame = _scrollView.bounds;
    for (NSInteger i = 0; i < 5; i++) {
        frame.origin.x = i*frame.size.width;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%ld",i]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.userInteractionEnabled = YES;
        imageView.frame = frame;
        [_scrollView addSubview:imageView];
        if (i == 4) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(self.view.frame.size.width*112/375, self.view.frame.size.height*500/667, self.view.frame.size.width*150/375, self.view.frame.size.height*100/667);
            [button setBackgroundImage:[UIImage imageNamed:@"Clickkk"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(Go) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
    }
}
- (void)Go{
    LoginViewController *controller = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)addPageControl{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height-40, self.view.frame.size.width-100, 40)];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    _pageControl.numberOfPages = 5;
    [_pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
}
- (void)pageControlClick:(UIPageControl *)pageControl {
    NSInteger currentPage = pageControl.currentPage;
    // 根据页码设置scrollView的滚动的偏移量
    [_scrollView setContentOffset:CGPointMake(currentPage*_scrollView.frame.size.width, 0) animated:YES];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //设置页码指示器,指定到相应的页
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end




















