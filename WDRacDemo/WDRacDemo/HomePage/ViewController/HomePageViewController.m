//
//  HomePageViewController.m
//  WDRacDemo
//
//  Created by ctcios2 on 2017/12/4.
//  Copyright © 2017年 wd. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageViewModel.h"
#import "HomePageTableViewCell.h"
#import <ReactiveCocoa.h>
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) HomePageViewModel *viewModel;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[HomePageViewModel alloc] init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"HomePageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    [self addBind];
    
    [_viewModel getDatas];
}

- (void)addBind {
    @weakify(self);
    [RACObserve(_viewModel, dataArray) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.viewModel.dataArray[indexPath.row];
    
    return cell;
}

@end
