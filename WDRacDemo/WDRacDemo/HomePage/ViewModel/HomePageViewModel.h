//
//  HomePageViewModel.h
//  WDRacDemo
//
//  Created by ctcios2 on 2017/12/4.
//  Copyright © 2017年 wd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageViewModel : NSObject

@property (nonatomic,strong) NSArray *dataArray;

- (void)getDatas;

@end
