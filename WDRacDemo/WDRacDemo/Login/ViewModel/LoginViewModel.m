//
//  LoginViewModel.m
//  WDRacDemo
//
//  Created by ctcios2 on 2017/12/3.
//  Copyright © 2017年 wd. All rights reserved.
//

//通过宏定义来模拟正确的用户名和密码
#define correctName @"aaaaaa"
#define correctassword @"aaaaaa"

#import "LoginViewModel.h"
#import <ReactiveCocoa.h>
@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        
        @weakify(self);
        [[RACObserve(self, name) filter:^BOOL(id value) {
            return value != nil;
        }] subscribeNext:^(NSString *value) {
            @strongify(self);
            //利用正则去除特殊字符
            value = [value stringByReplacingOccurrencesOfString:@"[^0-9a-zA-Z]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, value.length)];
            //用循环保证粘贴复制进入的字符串也会符合首位字符必须是字母的限制
            while (value.length > 0) {
                char c = [value characterAtIndex:0];
                
                if (c < '0' || c > '9') break;
                
                value = [value substringFromIndex:1];
            }
            if (![value isEqualToString:self.name]) self.name = value;
        }];
        //combineLatest:标识将两个信号结合起来,任何一个发生sendNext的时候均会出发新的信号的sendNext
        //reduce:Block中表示可以自定义将结合后的信号组合新的返回值
        RAC(self,buttonEnable) = [RACSignal combineLatest:@[RACObserve(self, name),RACObserve(self, password)] reduce:^id(NSString *name,NSString *password){
            return @(name.length > 5&& password.length > 5);
        }];
    }
    return self;
}

/**
 登录成功失败通过回调block将状态传递
 */
- (void)loginWithSuccess:(void (^)(void))success failture:(void (^)(NSString *))failture {
    BOOL correct = [self.name isEqualToString:correctName] && [self.password isEqualToString:correctassword];
    
    if (correct) {
        success();
    }else {
        failture(@"用户名或密码错误");
    }
}

@end
