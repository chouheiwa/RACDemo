//
//  LoginViewModel.h
//  WDRacDemo
//
//  Created by ctcios2 on 2017/12/3.
//  Copyright © 2017年 wd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

/**
 用户名
 */
@property (nonatomic,copy) NSString *name;

/**
 密码
 */
@property (nonatomic,copy) NSString *password;


/**
 按钮可以被点击
 */
@property (nonatomic,assign) BOOL buttonEnable;

- (void)loginWithSuccess:(void(^)(void))success failture:(void(^)(NSString *msg))failture;

@end
