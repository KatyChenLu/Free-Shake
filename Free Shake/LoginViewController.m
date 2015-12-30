//
//  LoginViewController.m
//  Free Shake
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 WuRunTao. All rights reserved.
//

#import "LoginViewController.h"
#import "UserManager.h"
#import "RegisterViewController.h"
#import "LeadViewController.h"

@interface LoginViewController ()

@property (nonatomic) NSArray *classArray;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIImageView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIButton *view3;
@property (weak, nonatomic) IBOutlet UIButton *view4;


@property (nonatomic) UserModel *user;

@end

@implementation LoginViewController

- (void)awakeFromNib{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}
- (CGRect)getRect:(UIView *)view{
    CGFloat width = self.view.frame.size.width/375;
    CGFloat height = self.view.frame.size.height/667;
    return CGRectMake(view.frame.origin.x*width, view.frame.origin.y*height, view.frame.size.width*width, view.frame.size.height*height);
}
//登陆
- (IBAction)login:(id)sender {
    self.user = [[UserModel alloc]init];
    if (_nameField.text.length == 0) {
        [self showAlertWithTitle:@"请输入用户名"];
        return;
    }else{
        UserModel *user = [[UserManager sharedInstance]fetchByName:_nameField.text];
        if (user) {
            if ([user.password isEqualToString: _passwordField.text]) {
                self.user = user;
                LeadViewController *controller = [[LeadViewController alloc]init];
                controller.user = self.user;
                [self.navigationController pushViewController:controller animated:YES];
            }else{
                [self showAlertWithTitle:@"密码错误"];
                _passwordField.text = @"";
            }
        }else{
            [self showAlertWithTitle:@"该用户不存在"];
            _nameField.text = @"";
            _passwordField.text = @"";
        }
    }
}
//注册
- (IBAction)registerNewUser:(id)sender {
    RegisterViewController *controller = [[RegisterViewController alloc]init];
    [controller setPassValue:^(UserModel *user) {
        self.user = user;
        self.nameField.text = user.name;
        self.passwordField.text = user.password;
    }];
    [self presentViewController:controller animated:YES completion:nil];
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
























