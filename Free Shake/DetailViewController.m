//
//  DetailViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moodImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageVIew;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}
//刷新页面数据
- (void)setUp{
    self.titleLabel.text = self.note.title;
    self.timeLabel.text = self.note.time;
    self.moodImageView.image = [UIImage imageNamed:self.note.mood];
    self.contentView.text = self.note.content;
    self.bgImageVIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@1",self.note.mood]];
}
- (NoteData *)note{
    if (_note == nil) {
        _note = [[NoteData alloc]init];
    }
    return _note;
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
