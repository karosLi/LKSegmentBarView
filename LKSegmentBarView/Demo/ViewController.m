//
//  ViewController.m
//  LKSegmentBarView
//
//  Created by karos li on 2018/6/13.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Color.h"
#import "LKSegmentBarView.h"

@interface ViewController ()

@property (nonatomic, strong) CAGradientLayer *backgroundLayer;
@property (nonatomic, strong) LKSegmentBarView *bodySegment;
@property (nonatomic, strong) LKSegmentBarView *bodySegment1;
@property (nonatomic, strong) LKSegmentBarView *bodySegment2;
@property (nonatomic, strong) LKSegmentBarView *bodySegment3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.backgroundLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.backgroundLayer];
    
    [self.view addSubview:self.bodySegment];
    [self.bodySegment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(74);
    }];
    
    [self.view addSubview:self.bodySegment1];
    [self.bodySegment1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodySegment.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(74);
    }];
    
    [self.view addSubview:self.bodySegment2];
    [self.bodySegment2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodySegment1.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(74);
    }];
    
    [self.view addSubview:self.bodySegment3];
    [self.bodySegment3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bodySegment2.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(74);
    }];
}

#pragma mark - getter
- (CAGradientLayer *)backgroundLayer {
    if (!_backgroundLayer) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor lk_colorWithHexString:@"#1A2748"].CGColor, (__bridge id)[UIColor lk_colorWithHexString:@"#203461"].CGColor, (__bridge id)[UIColor lk_colorWithHexString:@"#221B4B"].CGColor, (__bridge id)[UIColor lk_colorWithHexString:@"#14182C"].CGColor];
        gradientLayer.locations = @[@0.1, @0.25, @0.9];
        gradientLayer.startPoint = CGPointMake(0.135, 0);
        gradientLayer.endPoint = CGPointMake(0.25, 1);
        _backgroundLayer = gradientLayer;
    }
    
    return _backgroundLayer;
}

- (LKSegmentBarView *)bodySegment {
    if (!_bodySegment) {
        LKSegmentBarView *bodySegment = [LKSegmentBarView new];
        bodySegment.cornerType = LKSegmentBarViewCornerTypeSquare;
        bodySegment.numberOfSegment = 5;
        bodySegment.segmentColors = @[[UIColor lk_colorWithHexString:@"#FFC500"], [UIColor lk_colorWithHexString:@"#2BC385"], [UIColor lk_colorWithHexString:@"#FF5D47"], [UIColor lk_colorWithHexString:@"#FFC500"], [UIColor lk_colorWithHexString:@"#2BC385"]];
        bodySegment.padding = 18;
        bodySegment.splitColor = [UIColor colorWithWhite:1 alpha:0.3];
        bodySegment.splitWidth = 2;
        bodySegment.splitHeight = 18;
        bodySegment.indicatorColor = [UIColor colorWithWhite:1 alpha:0.6];
        bodySegment.currentSegment = 4;
        bodySegment.topTitleSpacingToSegment = 15;
        bodySegment.bottomTitleSpacingToSegment = 15;
        bodySegment.topTitles = @[[LKSegmentBarTitle title:@"潜力股女神"
                                                  titleFont:[UIFont systemFontOfSize:12]
                                                 titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                   [LKSegmentBarTitle title:@"丰满佳人"
                                                  titleFont:[UIFont systemFontOfSize:12]
                                                 titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                   [LKSegmentBarTitle title:@"邻家女孩"
                                                  titleFont:[UIFont systemFontOfSize:12]
                                                 titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                   [LKSegmentBarTitle title:@"维密天使"
                                                  titleFont:[UIFont systemFontOfSize:12]
                                                 titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                   [LKSegmentBarTitle title:@"喷火尤物"
                                                  titleFont:[UIFont systemFontOfSize:12]
                                                 titleColor:[UIColor colorWithWhite:1 alpha:0.6]]];
        
        bodySegment.bottomTitles = @[[LKSegmentBarTitle title:@"潜力股女神"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                     [LKSegmentBarTitle title:@"丰满佳人"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                     [LKSegmentBarTitle title:@"邻家女孩"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                     [LKSegmentBarTitle title:@"维密天使"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]]];
        _bodySegment = bodySegment;
    }
    
    return _bodySegment;
}

- (LKSegmentBarView *)bodySegment1 {
    if (!_bodySegment1) {
        LKSegmentBarView *bodySegment = [LKSegmentBarView new];
        bodySegment.numberOfSegment = 5;
        bodySegment.segmentGradientColors = @[[UIColor lk_colorWithHexString:@"#FFC631"], [UIColor lk_colorWithHexString:@"#FF6D59"], [UIColor lk_colorWithHexString:@"#FF5D47"]];
        bodySegment.padding = 18;
        bodySegment.splitImage = [UIImage imageNamed:@"heath_record_split_image"];
        bodySegment.splitWidth = 18;
        bodySegment.splitHeight = 18;
        bodySegment.indicatorImage = [UIImage imageNamed:@"heath_record_indicator_image_1"];
        bodySegment.currentSegment = 3;
        bodySegment.topTitleSpacingToSegment = 15;
        bodySegment.bottomTitleSpacingToSegment = 15;
        bodySegment.topTitles = @[[LKSegmentBarTitle title:@"潜力股女神"
                                                 titleFont:[UIFont systemFontOfSize:12]
                                                titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                  [LKSegmentBarTitle title:@"丰满佳人"
                                                 titleFont:[UIFont systemFontOfSize:12]
                                                titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                  [LKSegmentBarTitle title:@"邻家女孩"
                                                 titleFont:[UIFont systemFontOfSize:12]
                                                titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                  [LKSegmentBarTitle title:@"维密天使"
                                                 titleFont:[UIFont systemFontOfSize:12]
                                                titleColor:[UIColor colorWithWhite:1 alpha:0.6]],
                                  [LKSegmentBarTitle title:@"喷火尤物"
                                                 titleFont:[UIFont systemFontOfSize:12]
                                                titleColor:[UIColor colorWithWhite:1 alpha:0.6]]];
        
        bodySegment.bottomTitles = @[[LKSegmentBarTitle title:@"潜力股女神"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]],
                                     [LKSegmentBarTitle title:@"丰满佳人"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]],
                                     [LKSegmentBarTitle title:@"邻家女孩"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]],
                                     [LKSegmentBarTitle title:@"维密天使"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]],
                                     [LKSegmentBarTitle title:@"喷火尤物"
                                                  titleFont:[UIFont systemFontOfSize:12]
                                          selectedTitleFont:[UIFont systemFontOfSize:12]
                                                 titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                         selectedTitleColor:[UIColor whiteColor]]
                                     ];
        _bodySegment1 = bodySegment;
    }
    
    return _bodySegment1;
}


- (LKSegmentBarView *)bodySegment2 {
    if (!_bodySegment2) {
        LKSegmentBarView *bodySegment = [LKSegmentBarView new];
        bodySegment.numberOfSegment = 5;
        bodySegment.segmentGradientColors = @[[UIColor lk_colorWithHexString:@"#FFC631"], [UIColor lk_colorWithHexString:@"#FF6D59"], [UIColor lk_colorWithHexString:@"#FF5D47"]];
        bodySegment.padding = 18;
        bodySegment.splitColor = [UIColor blackColor];
        bodySegment.splitWidth = 1;
        bodySegment.indicatorImage = [UIImage imageNamed:@"heath_record_indicator_image_1"];
        bodySegment.currentSegment = 2;
        bodySegment.topTitleSpacingToSegment = 7;
        bodySegment.bottomTitleSpacingToSegment = 15;
        bodySegment.bottomTitles = @[[LKSegmentBarTitle title:@"潜力股女神"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]],
                                     [LKSegmentBarTitle title:@"丰满佳人"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]],
                                     [LKSegmentBarTitle title:@"邻家女孩"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]],
                                     [LKSegmentBarTitle title:@"维密天使"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]],
                                     [LKSegmentBarTitle title:@"喷火尤物"
                                                    titleFont:[UIFont systemFontOfSize:12]
                                            selectedTitleFont:[UIFont systemFontOfSize:12]
                                                   titleColor:[UIColor colorWithWhite:1 alpha:0.6]
                                           selectedTitleColor:[UIColor whiteColor]]
                                     ];
        _bodySegment2 = bodySegment;
    }
    
    return _bodySegment2;
}

- (LKSegmentBarView *)bodySegment3 {
    if (!_bodySegment3) {
        LKSegmentBarView *bodySegment = [LKSegmentBarView new];
        bodySegment.numberOfSegment = 5;
        bodySegment.segmentColors = @[[UIColor lk_colorWithHexString:@"#FFC500"], [UIColor lk_colorWithHexString:@"#2BC385"], [UIColor lk_colorWithHexString:@"#FF5D47"], [UIColor lk_colorWithHexString:@"#FFC500"], [UIColor lk_colorWithHexString:@"#2BC385"]];
        bodySegment.padding = 18;
        bodySegment.indicatorImage = [UIImage imageNamed:@"heath_record_indicator_image_1"];
        bodySegment.currentSegment = 1;
        bodySegment.topTitleSpacingToSegment = 7;
        bodySegment.bottomTitleSpacingToSegment = 7;
        _bodySegment3 = bodySegment;
    }
    
    return _bodySegment3;
}

@end

