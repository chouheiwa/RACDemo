//
//  HomePageModel.h
//  WDRacDemo
//
//  Created by ctcios2 on 2017/12/4.
//  Copyright © 2017年 wd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 这个model模拟的是一个tableViewCell需要的Model
 */
@interface HomePageModel : NSObject

/**
 排名
 */
@property (nonatomic,copy) NSString *number;

/**
 姓名
 */
@property (nonatomic,copy) NSString *name;

/**
 分数
 */
@property (nonatomic,copy) NSString *score;

/**
 总人数,这个字段模拟网络请求,将会延时返回
 */
@property (nonatomic,copy) NSString *totalNumber;

@end
