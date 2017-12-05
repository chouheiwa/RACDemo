//
//  WDRankingView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/24.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDRankingView.h"

@implementation WDRankingView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (int i = 0; i < 5; i ++) {
        UIImageView *starImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ranking_zero"]];
        
        if (i == 0) {
            starImage.image = [UIImage imageNamed:@"ranking_full"];
        }
        
        starImage.tag = 1000 + i;
        
        [self addSubview:starImage];
    }
}

- (void)layoutSubviews {
    CGFloat width = 25;
    CGFloat margin =  (self.frame.size.width - width * 5) / 5;
    CGFloat y = (self.frame.size.height - width) / 2;
    for (int i = 0; i < 5; i ++) {
        UIImageView *imageView = [self viewWithTag:i + 1000];
        
        imageView.frame = CGRectMake(margin / 2 + (width + margin) * i, y, width, width);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    
    CGPoint location = [touch locationInView:self];
    CGFloat width = self.frame.size.width / 5;
    
    NSInteger rank = (location.x / width + 1);
    if (rank < 1) {
        rank = 1;
    }else if (rank > 5){
        rank = 5;
    }
    
    [self setRanking:rank];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
}

- (void)setRanking:(NSInteger)ranking {
    _ranking = ranking;
    
    for (UIImageView *image in self.subviews) {
        if (image.tag - 999 <= ranking) {
            image.image = [UIImage imageNamed:@"ranking_full"];
        }else {
            image.image = [UIImage imageNamed:@"ranking_zero"];
        }
    }
}

@end
