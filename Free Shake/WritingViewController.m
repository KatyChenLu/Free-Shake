//
//  WritingViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/10/3.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "WritingViewController.h"
#import "RTUtil.h"

#define NormalColor [UIColor colorWithRed:32 green:63 blue:250 alpha:1.0]
#define SelectedColor [UIColor colorWithRed:252 green:29 blue:154 alpha:1.0]
#define kCompleteAlertTag 1000
#define kCancelAlertTag 1001

@interface WritingViewController ()<UIAlertViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *happyBtn;
@property (weak, nonatomic) IBOutlet UIButton *sadBtn;
@property (weak, nonatomic) IBOutlet UIButton *melancholyBtn;
@property (weak, nonatomic) IBOutlet UIButton *fighting;
@property (weak, nonatomic) IBOutlet UIImageView *selectVIew;

@property (nonatomic) NoteData *note;
@property (nonatomic) UIButton *lastButton;

@end

@implementation WritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dealOthers];
}
- (NoteData *)note{
    if (_note == nil) {
        _note = [[NoteData alloc]init];
    }
    return _note;
}
- (UserModel *)user{
    if (_user == nil) {
        _user = [[UserModel alloc]init];
    }
    return _user;
}
- (void)dealOthers{
    self.happyBtn.selected = YES;
    self.lastButton = _happyBtn;
    self.note.mood = [_happyBtn currentTitle];
}
- (IBAction)clickHappy:(UIButton *)sender {
    [self chooseMoodByButton:sender];
}
- (IBAction)clickSad:(UIButton *)sender {
    [self chooseMoodByButton:sender];
}
- (IBAction)clickMelancholy:(UIButton *)sender {
    [self chooseMoodByButton:sender];
}
- (IBAction)clickFIghting:(UIButton *)sender {
    [self chooseMoodByButton:sender];
}
//选择心情
- (void)chooseMoodByButton:(UIButton *)sender{
    if (sender == self.lastButton) {
        return;
    }
    self.lastButton.selected = NO;
    [self.lastButton setBackgroundColor:[UIColor colorWithRed:0.988 green:0.114 blue:0.604 alpha:1.0]];
    self.lastButton = sender;
    
    sender.selected = YES;
    [sender setBackgroundColor:[UIColor colorWithRed:0.114 green:0.247 blue:0.980 alpha:1.0]];
    
    CGPoint center = self.selectVIew.center;
    center.x = sender.center.x + 60;
    center.y = sender.center.y;
    self.selectVIew.center = center;
    
    self.note.mood = [sender currentTitle];
}
- (IBAction)completeWriting:(id)sender {
    if (_titleLabel.text.length == 0 || _contentView.text.length == 0) {
        [self showAlertWithTitle:@"请输入完整信息" tag:999];
        return;
    }
    [self showAlertWithTitle:@"确认完成编辑?" tag:kCompleteAlertTag];
}
- (IBAction)cancelWriting:(id)sender {
    [self showAlertWithTitle:@"确认取消编辑?" tag:kCancelAlertTag];
}
//弹出警告框
- (void)showAlertWithTitle:(NSString *)title tag:(NSInteger)tag{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.tag = tag;
    alert.delegate = self;
    [alert show];
}
#pragma mark - <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        switch (alertView.tag) {
            case kCompleteAlertTag:
                [self complete];
                break;
            case kCancelAlertTag:
                [self cancel];
                break;
            default:
                break;
        }
    }
}
- (void)complete{
    self.note.title = _titleLabel.text;
    _note.content = _contentView.text;
    _note.userName = self.user.name;
    _note.date_time = [RTUtil dateByFormatter:@"yyyy年MM月dd日 HH:mm:ss EEEE"];
    _note.date = [RTUtil dateByFormatter:@"yyyy年MM月dd日"];
    _note.time = [RTUtil dateByFormatter:@"HH:mm:ss EEEE"];
    [[NoteManager sharedInstance]add:_note];
    if (_passValueHandler) {
        _passValueHandler(_note);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
//退出键盘return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
    }
    return YES;
}

@end






















