//
//  HomePageViewModel.m
//  WDRacDemo
//
//  Created by ctcios2 on 2017/12/4.
//  Copyright © 2017年 wd. All rights reserved.
//

#import "HomePageViewModel.h"
#import "HomePageModel.h"

@interface HomePageViewModel ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation HomePageViewModel
- (void)setTimer:(NSTimer *)timer {
    if (!_timer) {
        [_timer invalidate];
    }
    _timer = timer;
}

//模拟网络通过延时加载数据
- (void)getDatas {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 40; i ++) {
        [array addObject:({
            HomePageModel *model = [[HomePageModel alloc] init];
            
            model.name = @"小明";
            
            model.number = @"10";
            
            model.score = @"92";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                model.totalNumber = [NSString stringWithFormat:@"%d",i + 10];
            });
            
            model;
        })];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataArray = array;
    });
    //通过timer模拟需要定时刷新的数据
    if (@available(iOS 10.0, *)) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self timerAction];
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)timerAction {
    for (HomePageModel *model in self.dataArray) {
        model.totalNumber = [NSString stringWithFormat:@"%ld",model.totalNumber.integerValue + 1];
    }
}

- (void)dealloc {
    if (_timer) {
        [_timer invalidate];
    }
}

@end
