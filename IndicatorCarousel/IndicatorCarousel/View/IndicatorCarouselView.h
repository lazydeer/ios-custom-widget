//
//  IndicatorCarouselView.h
//  HBBForPrincipal
//
//  Created by Zhiqiang Deng on 16/1/5.
//  Copyright © 2016年 HXKid. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndicatorCarouselDelegate,IndicatorCarouselDataSource;

@interface IndicatorCarouselView : UIView
//被轮播的view源数组
@property (nonatomic,assign) CGSize itemSize;

@property (nonatomic, weak) IBOutlet __nullable id<IndicatorCarouselDataSource> dataSource;
@property (nonatomic, weak) IBOutlet __nullable id<IndicatorCarouselDelegate> delegate;

@end

#pragma mark--> 底部指示器
@interface IndicatorView : UIView
@property (nonatomic) NSInteger itemCount;
@property (nonatomic) NSInteger currentActiveItemIndex;

-(instancetype)initWithItemCount:(NSInteger)itemCount andFrame:(CGRect)frame;

@end



@protocol IndicatorCarouselDelegate <NSObject>

@optional
- (void)carousel:(IndicatorCarouselView *)indicatorCarousel didSelectItemAtIndex:(NSInteger)index;
- (void)carousel:(IndicatorCarouselView *)indicatorCarousel didSelectIndicatorAtIndex:(NSInteger)index;
@end

@protocol IndicatorCarouselDataSource <NSObject>
- (NSInteger)numberOfItemsInCarousel:(IndicatorCarouselView *)carousel;
- (UIView *)carousel:(IndicatorCarouselView *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view;

@end

