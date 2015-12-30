//
//  RegisterViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setPassValue:(void (^)(UserModel *))block{
    _block = [block copy];
}
//注册
- (IBAction)registerNewUser:(id)sender {
    if (_nameField.text.length == 0 || _passwordField.text.length == 0 || _emailField.text.length == 0) {
        [self showAlertWithTitle:@"注册信息不完整"];
    }else{
        UserModel *user = [[UserManager sharedInstance]fetchByName:_nameField.text];
        if (user) {
            [self showAlertWithTitle:@"用户已存在"];
            _passwordField.text = @"";
            _emailField.text = @"";
        }else{
            self.user = [[UserModel alloc]init];
            self.user.name = _nameField.text;
            self.user.password = _passwordField.text;
            self.user.email = _emailField.text;
            [self dismissViewControllerAnimated:YES completion:nil];
            [[UserManager sharedInstance]add:self.user];
            if (_block) {
                _block(_user);
            }
        }
    }
}
//取消注册
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//弹出警告框
- (void)showAlertWithTitle:(NSString *)title{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

@end












