//
//  GBStarRateView.h
//  GBStarRateViewDemo
//
//  Created by midas on 2018/7/19.
//  Copyright © 2018年 Midas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GBStarRateViewStyle){
    
    GBStarRateViewStyleWholeStar = 0,//全星评分
    GBStarRateViewStyleHalfStar = 1, //可半星评分
    GBStarRateViewStyleIncompleteStar = 2,//不完整星评分
};
@class GBStarRateView;
@protocol GBStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(GBStarRateView *)starRateView didSelecteStarAtStarRate:(CGFloat)starRate;
@end

typedef void(^GBStarRateDidSelectStarBlock)(GBStarRateView *starRateView, CGFloat starRate);

@interface GBStarRateView : UIView

@property (nonatomic, assign) GBStarRateViewStyle style; //星星评分样式
@property (nonatomic, weak) id <GBStarRateViewDelegate> delegate; //代理
@property (nonatomic, assign) NSInteger numberOfStars; //星星数量 默认为5
@property (nonatomic, assign) CGFloat currentStarRate; //当前打分 默认为0.0
@property (nonatomic, assign) CGFloat spacingBetweenStars; //星星间隔 默认为10
@property (nonatomic, assign) CGSize starSize; //星星尺寸 默认 {24,24}
@property (nonatomic, strong) UIImage *starImage; //未选中star image 有默认图片
@property (nonatomic, strong) UIImage *currentStarImage; //选中star image 有默认图片
@property (nonatomic, assign) BOOL isAnimation; //是否动画 默认YES
@property (nonatomic, assign) BOOL allowSlideScore; //是否滑动打分 默认NO 适用于不完整星星打分
@property (nonatomic, assign) BOOL allowClickScore; //是否点击打分 默认YES
@property (nonatomic, copy) GBStarRateDidSelectStarBlock didSelectStarBlock;//点击或滑动打分的回调

- (instancetype)initWithFrame:(CGRect)frame style:(GBStarRateViewStyle)style numberOfStars:(NSInteger)numbersOfStars isAnimation:(BOOL)isAnimation delegate:(id <GBStarRateViewDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame style:(GBStarRateViewStyle)style numberOfStars:(NSInteger)numbersOfStars isAnimation:(BOOL)isAnimation finish:(GBStarRateDidSelectStarBlock)finish;
@end

