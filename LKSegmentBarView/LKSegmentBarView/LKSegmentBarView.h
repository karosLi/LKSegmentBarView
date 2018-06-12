//
//  LKSegmentBarView.h
//  LKSegmentBarView
//
//  Created by karos li on 2018/6/12.
//  Copyright © 2018年 karos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKSegmentBarTitle : NSObject

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 标题选中字体
 */
@property (nonatomic, strong) UIFont *selectedTitleFont;

/**
 标题颜色
 */
@property (nonatomic, copy) UIColor *titleColor;

/**
 标题选中颜色
 */
@property (nonatomic, copy) UIColor *selectedTitleColor;

+ (LKSegmentBarTitle *)title:(NSString *)title
                   titleFont:(UIFont *)titleFont
                  titleColor:(UIColor *)titleColor;

+ (LKSegmentBarTitle *)title:(NSString *)title
                   titleFont:(UIFont *)titleFont
           selectedTitleFont:(UIFont *)selectedTitleFont
                  titleColor:(UIColor *)titleColor
          selectedTitleColor:(UIColor *)selectedTitleColor;

@end


/**
 * 分段圆角类型
 */
typedef NS_ENUM (NSUInteger, LKSegmentBarViewCornerType) {
    /**
     * 圆角
     */
    LKSegmentBarViewCornerTypeRounded = 0,
    /**
     * 正方形
     */
    LKSegmentBarViewCornerTypeSquare    = 1,
};

@interface LKSegmentBarView : UIView

/**
 分段圆角类型
 */
@property (nonatomic, assign) LKSegmentBarViewCornerType cornerType;

/**
 分段圆角弧度，默认是 0，代表是视图高度的一半
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 分段总数量
 */
@property (nonatomic, assign) NSInteger numberOfSegment;

/**
 当前选中索引
 */
@property (nonatomic, assign) NSInteger currentSegment;

/**
 分段颜色
 */
@property (nonatomic, strong) NSArray<UIColor *> *segmentColors;

/**
 分段渐变颜色
 */
@property (nonatomic, strong) NSArray<UIColor *> *segmentGradientColors;

/**
 分段高度，默认 9
 */
@property (nonatomic, assign) CGFloat segmentHeight;

/**
 分段分割颜色
 */
@property (nonatomic, strong) UIColor *splitColor;

/**
 分段分割图片
 */
@property (nonatomic, strong) UIImage *splitImage;

/**
 分段分割宽度
 */
@property (nonatomic, assign) CGFloat splitWidth;

/**
 分段分割高度，默认等于分段高度
 */
@property (nonatomic, assign) CGFloat splitHeight;

/**
 分段控件左右内边距，默认 0
 */
@property (nonatomic, assign) CGFloat padding;

/**
 分段指示器颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 分段指示器图片
 */
@property (nonatomic, strong) UIImage *indicatorImage;

/**
 分段指示器尺寸，默认是 20x20
 */
@property (nonatomic, assign) CGSize indicatorSize;

/**
 上标题，推荐标题数量等于 numberOfSegment 或者等于 numberOfSegment - 1，否则标题位置不可预测
 */
@property (nonatomic, strong) NSArray<LKSegmentBarTitle *> *topTitles;

/**
 上标题距离分段的距离
 */
@property (nonatomic, assign) CGFloat topTitleSpacingToSegment;

/**
 下标题，推荐标题数量等于 numberOfSegment 或者等于 numberOfSegment - 1，否则标题位置不可预测
 */
@property (nonatomic, strong) NSArray<LKSegmentBarTitle *> *bottomTitles;

/**
 下标题距离分段的距离
 */
@property (nonatomic, assign) CGFloat bottomTitleSpacingToSegment;

@end
