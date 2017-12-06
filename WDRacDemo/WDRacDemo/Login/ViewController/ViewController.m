//
//  ViewController.m
//  WDRacDemo
//
//  Created by ctcios2 on 2017/12/3.
//  Copyright © 2017年 wd. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewModel.h"
#import <ReactiveCocoa.h>

#import "HomePageViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic,strong) LoginViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[LoginViewModel alloc] init];
    
    [self.loginButton setTitleColor:[UIColor grayColor] forState:(UIControlStateDisabled)];
    [self.loginButton setTitleColor:[UIColor cyanColor] forState:(UIControlStateNormal)];
    
    [self addBind];
    @weakify(self);
    //button的点击事件用RAC调用
    [[self.loginButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel loginWithSuccess:^{
            [self.navigationController pushViewController:[HomePageViewController new] animated:YES];
        } failture:^(NSString *msg) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:msg preferredStyle:(UIAlertControllerStyleAlert)];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }];
}

- (void)addBind {
    //将用户名输入框和viewModel中的name字段进行绑定，正向绑定(viewModel中的name字段发生变化时,保证textField中的显示也会变化)
    //RAC(,) 是一个赋值的宏定义，其意义就相当于当一个RACSignal 被发送sendNext的时候,将其中的值赋值给定义的定义后的变量
    //RACObserve(,)
    RAC(_userNameTextField,text) = RACObserve(_viewModel, name);
    //此处加正向绑定,使TextField的值传递能即时传递到viewModel中
    RAC(_viewModel,name) = _userNameTextField.rac_textSignal;
    
    RAC(_passwordTextField,text) = RACObserve(_viewModel, password);
    RAC(_viewModel,password) = _passwordTextField.rac_textSignal;
    //将按钮的可用与ViewModel的按钮可用状态进行绑定
    RAC(_loginButton,enabled) = RACObserve(_viewModel, buttonEnable);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
