//
//  GBStarRateView.m
//  GBStarRateViewDemo
//
//  Created by midas on 2018/7/19.
//  Copyright © 2018年 Midas. All rights reserved.
//

#import "GBStarRateView.h"

static CGFloat const kAnimatinDuration = 0.3;

@interface GBStarRateView ()

@property (nonatomic, strong) NSMutableArray <UIView *> *starsContentViews;

@end


@implementation GBStarRateView

@synthesize starSize = _starSize;

- (id)init {
    
    if (self = [super init]) {
        
        [self config];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self config];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self config];
    }
    return self;
}
#pragma mark - 基本配置
- (void)config {
    
    self.style = GBStarRateViewStyleWholeStar;
    self.numberOfStars = 5;
    self.spacingBetweenStars = 10;
    _starSize = CGSizeMake(24, 24);
    self.currentStarImage = [UIImage imageNamed:@"ic_star_selected"];
    self.starImage = [UIImage imageNamed:@"ic_star_default"];
    self.isAnimation = YES;
    self.allowClickScore = YES;
    self.allowSlideScore = NO;
}

#pragma mark - 创建视图
- (void)resetStarsContentView {
    
    for (UIView *starContentView in self.starsContentViews) {
        [starContentView removeFromSuperview];
    }
    [self.starsContentViews removeAllObjects];
    
    [self createStarsContentView:self.starImage starRate:_numberOfStars];
    [self createStarsContentView:self.currentStarImage starRate:_currentStarRate];
}

- (void)createStarsContentView:(UIImage *)starImage starRate:(CGFloat)starRate {
    
    if (self.numberOfStars == 0) {
        return;
    }
    CGRect frame = [self frameForStarsContentViewAtCurrentStarRate:starRate];
    UIView *starsContentView = [[UIView alloc] initWithFrame:frame];
    starsContentView.clipsToBounds = YES;//必须要设置，不设试试效果
    [self addSubview:starsContentView];
    
    for (int i = 0; i < self.numberOfStars; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:starImage];
        imageView.frame = CGRectMake((self.starSize.width + self.spacingBetweenStars) * i, 0, self.starSize.width, self.starSize.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [starsContentView addSubview:imageView];
    }
    
    [self.starsContentViews addObject:starsContentView];
}
#pragma mark - StarsContentView frame
- (CGRect)frameForStarsContentViewAtCurrentStarRate:(CGFloat)currentStarRate {
    
    NSInteger index = (NSInteger)floor(currentStarRate);
    CGFloat w = (self.starSize.width + self.spacingBetweenStars) * index + (currentStarRate - index) * self.starSize.width;
    CGFloat x = (CGRectGetWidth(self.bounds) - [self sizeForNumberOfStar:self.numberOfStars].width) * 0.5;
    CGFloat y = (CGRectGetHeight(self.bounds) - [self sizeForNumberOfStar:self.numberOfStars].height) * 0.5;
    CGFloat h = self.starSize.height;
    return CGRectMake(x, y, w, h);
}

#pragma mark - setter
- (void)setNumberOfStars:(NSInteger)numberOfStars {
    
    if (_numberOfStars != numberOfStars) {
        _numberOfStars = numberOfStars;
        [self resetStarsContentView];
    }
}

- (void)setSpacingBetweenStars:(CGFloat)spacingBetweenStars {
    
    if (_spacingBetweenStars != spacingBetweenStars) {
        _spacingBetweenStars = spacingBetweenStars;
        [self resetStarsContentView];
    }
}

- (void)setStarImage:(UIImage *)starImage {
    
    if (_starImage != starImage) {
        _starImage = starImage;
        [self resetStarsContentView];
    }
}
- (void)setCurrentStarImage:(UIImage *)currentStarImage {
    
    if (_currentStarImage != currentStarImage) {
        _currentStarImage = currentStarImage;
        [self resetStarsContentView];
    }
}

- (void)setStarSize:(CGSize)starSize {
    
    if (!CGSizeEqualToSize(_starSize, starSize)) {
        _starSize = starSize;
        [self resetStarsContentView];
    }
}

- (CGSize)starSize {

    if (CGSizeEqualToSize(_starSize, CGSizeZero)) {

        _starSize = self.starImage.size;
    }
    return _starSize;
}

- (void)setCurrentStarRate:(CGFloat)currentStarRate {
    
    if (self.starsContentViews.count == 0 || _currentStarRate == currentStarRate) {
        return;
    }
    if (currentStarRate  < 0) {
        return;
    } else if (currentStarRate > self.numberOfStars) {
        
        _currentStarRate = self.numberOfStars;
    } else {
        _currentStarRate = currentStarRate;
    }

    UIView *starsContentView = self.starsContentViews[1];
    [UIView animateWithDuration:_isAnimation ? kAnimatinDuration : 0.0 animations:^{
        starsContentView.frame = [self frameForStarsContentViewAtCurrentStarRate:currentStarRate];
    }];
    if (self.didSelectStarBlock) {
        self.didSelectStarBlock(self, currentStarRate);
    }
    if ([self.delegate respondsToSelector:@selector(starRateView:didSelecteStarAtStarRate:)]) {
        [self.delegate starRateView:self didSelecteStarAtStarRate:currentStarRate];
    }
}

#pragma mark - event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (_allowClickScore) {
        UITouch *touch = [touches anyObject];
        UIView *view = touch.view;
        if (view != self) {
            CGPoint point = [touch locationInView:view];
            [self setupScoreWithOffsetX:point.x];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_allowSlideScore) {
        UITouch *touch = [touches anyObject];
        UIView *view = touch.view;
        if (view != self && [self.starsContentViews containsObject:view]) {
            CGPoint point = [touch locationInView:view];
            [self setupScoreWithOffsetX:point.x];
        }
    }
}

#pragma mark - 根据offsetx计算分数
- (void)setupScoreWithOffsetX:(CGFloat)offsetX {
    
    NSInteger index = offsetX / (self.starSize.width + self.spacingBetweenStars);
    CGFloat mathOffsetX =  (index + 1) * self.starSize.width + index * self.spacingBetweenStars;
    CGFloat score = (offsetX - index * self.spacingBetweenStars)/(self.starSize.width);
    if (offsetX > mathOffsetX) {
        score = index + 1;
    }
    NSLog(@"offsetX=%f,index=%ld, score=%f", offsetX, index, score);
    self.currentStarRate = [self currentStarRateWithScore:score];
}

- (CGFloat)currentStarRateWithScore:(CGFloat)score {
    
    switch (self.style) {
        case GBStarRateViewStyleWholeStar:
            score = ceil(score);
            break;
        case GBStarRateViewStyleHalfStar:
            score = round(score) > score ? round(score) : (ceil(score)-0.5);
            break;
        case GBStarRateViewStyleIncompleteStar:
            score = score;
            break;
    }
    return score;
}


- (CGSize)sizeForNumberOfStar:(NSInteger)starCount {
    
    CGFloat w = (self.starSize.width + self.spacingBetweenStars)*starCount - self.spacingBetweenStars;
    return CGSizeMake(w, self.starSize.height);
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    //实现在星星范围内也能响应 即使父视图高度少于星星高度
    if (point.y <= (self.starImage.size.height*0.5) && point.y >= - (self.starImage.size.height*0.5 - self.bounds.size.height*0.5)) {
        return YES;
    }
    return [super pointInside:point withEvent:event];
}


#pragma mark - getter
- (NSMutableArray<UIView *> *)starsContentViews {
    
    if (!_starsContentViews) {
        _starsContentViews = [NSMutableArray array];
    }
    return _starsContentViews;
}
@end
