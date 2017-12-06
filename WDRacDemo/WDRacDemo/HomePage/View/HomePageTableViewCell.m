//
//  HomePageTableViewCell.m
//  WDRacDemo
//
//  Created by ctcios2 on 2017/12/4.
//  Copyright © 2017年 wd. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import <ReactiveCocoa.h>
@interface HomePageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberLabel;

@property (nonatomic,assign) NSInteger count;

@end

@implementation HomePageTableViewCell
static NSInteger i = 0;
- (void)awakeFromNib {
    [super awakeFromNib];
    _count = i;
    i ++;
}
- (void)setModel:(HomePageModel *)model {
    _model = model;
    
    _numberLabel.text = model.number;
    _nameLabel.text = model.name;
    _scoreLabel.text = model.score;
    @weakify(self);
    
    
    //异步将数据更新,同时在tableViewCell的model更换后及时的将之前的观察置空,防止cell被重用后,原有Model数据更新后产生数据错乱
    //takeUntil:代表着这个信号直到另一个信号发出的时候会被释放
    
    [[RACObserve(model, totalNumber) takeUntil:[self rac_valuesAndChangesForKeyPath:@keypath(self, model) options:(NSKeyValueObservingOptionNew) observer:self]] subscribeNext:^(id x) {
        @strongify(self);
        
        self.totalNumberLabel.text = x;
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
