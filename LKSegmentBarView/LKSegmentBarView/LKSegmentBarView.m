//
//  LKSegmentBarView.m
//  LKSegmentBarView
//
//  Created by karos li on 2018/6/12.
//  Copyright © 2018年 karos. All rights reserved.

#import "LKSegmentBarView.h"

@implementation LKSegmentBarTitle

+ (LKSegmentBarTitle *)title:(NSString *)title
                   titleFont:(UIFont *)titleFont
                  titleColor:(UIColor *)titleColor {
    LKSegmentBarTitle *obj = [LKSegmentBarTitle new];
    obj.title = title;
    obj.titleFont = titleFont;
    obj.titleColor = titleColor;
    
    return obj;
}

+ (LKSegmentBarTitle *)title:(NSString *)title
                   titleFont:(UIFont *)titleFont
           selectedTitleFont:(UIFont *)selectedTitleFont
                  titleColor:(UIColor *)titleColor
          selectedTitleColor:(UIColor *)selectedTitleColor {
    LKSegmentBarTitle *obj = [LKSegmentBarTitle new];
    obj.title = title;
    obj.titleFont = titleFont;
    obj.selectedTitleFont = selectedTitleFont;
    obj.titleColor = titleColor;
    obj.selectedTitleColor = selectedTitleColor;
    
    return obj;
}

@end

@interface LKSegmentBarView()

@property (nonatomic, assign) CGFloat internalCornerRadius;
@property (nonatomic, strong) NSArray *segmentGradientCGColors;

@end

@implementation LKSegmentBarView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self initializeSegmentBar];
    }
    
    return self;
}

- (void)initializeSegmentBar {
    self.backgroundColor = [UIColor clearColor];
    _segmentHeight = 9;
    _indicatorSize = CGSizeMake(20, 20);
}

#pragma mark - public method
- (void)setSegmentGradientColors:(NSArray<UIColor *> *)segmentGradientColors {
    _segmentGradientColors = segmentGradientColors;
    
    NSMutableArray *colors  = [NSMutableArray arrayWithCapacity:[segmentGradientColors count]];
    for (UIColor *color in segmentGradientColors) {
        [colors addObject:(id)color.CGColor];
    }
    self.segmentGradientCGColors = colors;
}

- (void)setSegmentColors:(NSArray<UIColor *> *)segmentColors {
    _segmentColors = segmentColors;
}

- (void)setCurrentSegment:(NSInteger)currentSegment {
    _currentSegment = currentSegment;
    [self setNeedsDisplay];
}

#pragma mark - draw
- (void)drawRect:(CGRect)rect {
    if (self.numberOfSegment == 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat topY = 0;
    CGRect paddingRect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, self.padding, 0, self.padding));
    
    // 画上部文字
    [self drawTitles:self.topTitles inContext:context withRect:paddingRect topY:&topY];
    
    // 画分段背景
    topY += self.topTitleSpacingToSegment;
    [self drawSegmentBarBackground:context withRect:paddingRect topY:&topY];
    
    // 画分隔符
    [self drawSegmentSplit:context withRect:paddingRect topY:topY - self.segmentHeight];
    
    // 画指示器
    [self drawSegmentIndicator:context withRect:paddingRect topY:topY - self.segmentHeight];
    
    // 画下部文字
    topY += self.bottomTitleSpacingToSegment;
    [self drawTitles:self.bottomTitles inContext:context withRect:paddingRect topY:&topY];
}

- (void)drawTitles:(NSArray<LKSegmentBarTitle *> *)titles inContext:(CGContextRef)context withRect:(CGRect)rect topY:(CGFloat *)topY {
    if (titles.count > 0) {
        BOOL needCenterTitle = NO;
        if (titles.count + 1 == self.numberOfSegment) { // 当标题数量刚好比分段数量少一个时，就需要居中显示标题，否则就需要平均分标题空间
            needCenterTitle = YES;
        }
        
        CGFloat maxTopY = 0;
        CGFloat width = rect.size.width / titles.count;
        CGFloat segmentWidth = rect.size.width / self.numberOfSegment;
        CGFloat leftExtraWidth = (needCenterTitle ? segmentWidth / 2.0 : 0);
        if (needCenterTitle) {
            width = (rect.size.width - leftExtraWidth * 2.0) / titles.count;
        }
        CGContextSaveGState(context);
        {
            // 只计算一行文本的高度
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            
            NSMutableDictionary *calcAttributes = [NSMutableDictionary dictionary];
            calcAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
            
            for (NSInteger i = 0; i < titles.count; i++) {
                LKSegmentBarTitle *obj = titles[i];
                
                CGRect calcRect = [obj.title boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:calcAttributes context:nil];
                CGRect titleRect = CGRectMake(leftExtraWidth + rect.origin.x + width * i, *topY, width, calcRect.size.height);
                
                NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
                attributes[NSParagraphStyleAttributeName] = paragraphStyle;
                if (obj.titleFont) {
                    attributes[NSFontAttributeName] = (self.currentSegment == i && obj.selectedTitleFont) ? obj.selectedTitleFont : obj.titleFont;
                }
                if (obj.titleColor) {
                    attributes[NSForegroundColorAttributeName] = (self.currentSegment == i && obj.selectedTitleColor) ? obj.selectedTitleColor : obj.titleColor;
                }
                
                [obj.title drawInRect:titleRect withAttributes:attributes];
                maxTopY = MAX(maxTopY, CGRectGetMaxY(titleRect));
            }
        }
        CGContextRestoreGState(context);
        *topY = maxTopY;
    }
}

- (void)drawSegmentBarBackground:(CGContextRef)context withRect:(CGRect)rect topY:(CGFloat *)topY {
    CGRect segmentRect = rect;
    segmentRect.origin.y = *topY;
    segmentRect.size.height = self.segmentHeight;
    
    self.internalCornerRadius = 0;
    if (self.cornerType == LKSegmentBarViewCornerTypeRounded) {
        if (self.cornerRadius > 0) {
            self.internalCornerRadius = _cornerRadius;
        } else {
            self.internalCornerRadius = segmentRect.size.height / 2;
        }
    }
    
    CGContextSaveGState(context);
    {
        if (self.segmentGradientColors.count > 0) { // 渐变色
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGRect gradientRect = segmentRect;
            UIBezierPath *progressBounds = [UIBezierPath bezierPathWithRoundedRect:gradientRect cornerRadius:self.internalCornerRadius];
            CGContextAddPath(context, [progressBounds CGPath]);
            CGContextClip(context);
            
            CFArrayRef colorRefs  = (__bridge CFArrayRef)self.segmentGradientCGColors;
            NSUInteger colorCount = [self.segmentGradientCGColors count];
            
            CGFloat delta      = 1.0f / colorCount;
            CGFloat semi_delta = delta / 2.0f;
            CGFloat locations[colorCount];
            
            for (NSInteger i = 0; i < colorCount; i++) {
                locations[i] = delta * i + semi_delta;
            }
            
            CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colorRefs, locations);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMinX(gradientRect), CGRectGetMinY(gradientRect)), CGPointMake(CGRectGetMinX(gradientRect) + CGRectGetWidth(gradientRect), CGRectGetMinY(gradientRect)), (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
            
            CGGradientRelease(gradient);
            CGColorSpaceRelease(colorSpace);
        } else if (self.segmentColors.count > 0) { // 分段颜色
            CGFloat width = segmentRect.size.width / self.segmentColors.count;
            CGFloat height = self.segmentHeight;
            CGFloat segmentTopY = segmentRect.origin.y;
            
            UIBezierPath *progressBounds = [UIBezierPath bezierPathWithRoundedRect:segmentRect cornerRadius:self.internalCornerRadius];
            CGContextAddPath(context, [progressBounds CGPath]);
            CGContextClip(context);
            
            for (NSInteger i = 0; i < self.segmentColors.count; i++) {
                CGRect drawRect = CGRectMake(segmentRect.origin.x + width * i, segmentTopY, width, height);
                
                CGContextAddRect(context, drawRect);
                [self.segmentColors[i] set];
                CGContextDrawPath(context, kCGPathFill);
            }
        }
    }
    CGContextRestoreGState(context);
    *topY = CGRectGetMaxY(segmentRect);
}

- (void)drawSegmentSplit:(CGContextRef)context withRect:(CGRect)rect topY:(CGFloat)topY {
    if (self.splitWidth && (self.splitColor || self.splitImage)) {
        CGFloat width = rect.size.width / self.numberOfSegment;
        CGFloat height = self.splitHeight > 0 ? self.splitHeight : self.segmentHeight;
        CGFloat segmentTopY = topY;
        CGContextSaveGState(context);
        {
            for (NSInteger i = 1; i < self.numberOfSegment; i++) {
                CGRect drawRect = CGRectMake(rect.origin.x + width * i - (self.splitWidth / 2.0), segmentTopY - (height - self.segmentHeight) / 2.0, self.splitWidth, height);
                
                if (self.splitColor) {
                    CGContextAddRect(context, drawRect);
                } else if (self.splitImage) {
                    [self.splitImage drawInRect:drawRect];
                }
            }
            
            if (self.splitColor) {
                [self.splitColor set];
                CGContextDrawPath(context, kCGPathFill);
            }
        }
        CGContextRestoreGState(context);
    }
}

- (void)drawSegmentIndicator:(CGContextRef)context withRect:(CGRect)rect topY:(CGFloat)topY {
    if (self.indicatorColor || self.indicatorImage) {
        CGFloat width = rect.size.width / self.numberOfSegment;
        CGFloat indicatorWidth = self.indicatorSize.width;
        CGFloat indicatorHeight = self.indicatorSize.height;
        CGFloat segmentTopY = topY;
        CGContextSaveGState(context);
        {
            CGRect drawRect = CGRectMake(rect.origin.x + width * self.currentSegment + (width - indicatorWidth) / 2.0, segmentTopY - (indicatorHeight - self.segmentHeight) / 2.0, indicatorWidth, indicatorHeight);
            
            if (self.indicatorColor) {
                CGContextAddRect(context, drawRect);
                [self.indicatorColor set];
                CGContextDrawPath(context, kCGPathFill);
            } else if (self.indicatorImage) {
                [self.indicatorImage drawInRect:drawRect];
            }
        }
        CGContextRestoreGState(context);
    }
}

@end
