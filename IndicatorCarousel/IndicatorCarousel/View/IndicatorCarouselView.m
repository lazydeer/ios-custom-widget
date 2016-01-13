//
//  IndicatorCarouselView.m
//  HBBForPrincipal
//
//  Created by Zhiqiang Deng on 16/1/5.
//  Copyright © 2016年 HXKid. All rights reserved.
//

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


#import "IndicatorCarouselView.h"
#import "ZQCardView.h"
#import "iCarousel.h"
#import <UIKit/UIKit.h>

static const CGFloat indicatorWidth = 8.0f;
static const CGFloat indicatorSpace = 18.0f;
static const CGFloat indicatorButtomToScreen = 42.0f;

@interface IndicatorCarouselView()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,strong) iCarousel *carouselView;
@property (nonatomic,strong) IndicatorView *indicatorView;
@end

@implementation IndicatorCarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //宽度减去俩边的间隔，高度减去为下方留的指示器
        _itemSize = CGSizeMake(self.frame.size.width-80, self.frame.size.height - 120);
        _carouselView = [[iCarousel alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height - 120)];
        _carouselView.backgroundColor = [UIColor clearColor];
        _carouselView.dataSource = self;
        _carouselView.delegate = self;
        _carouselView.bounces = YES;
        _carouselView.bounceDistance = 0.3;
        _carouselView.pagingEnabled = YES;
        _carouselView.type = iCarouselTypeCustom;
        [self addSubview:_carouselView];
    }
    return self;
}

-(void)setSourceData:(NSArray *)sourceData{
    self.indicatorView.itemCount = sourceData.count;
    [self refreshSelf];
    [self.indicatorView setNeedsDisplay];
}

-(void)refreshSelf
{
    _indicatorView.frame = [self calculateIndicatorFrame];
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    NSLog(@"XXXX");
    [self.carouselView reloadData];
}

-(void)setDataSource:(id<IndicatorCarouselDataSource>)dataSource
{
    _dataSource = dataSource;
    _indicatorView = [[IndicatorView alloc]initWithItemCount:[_dataSource numberOfItemsInCarousel:self] andFrame:[self calculateIndicatorFrame]];
    [self addSubview:_indicatorView];
    
}

//计算indicator的frame
-(CGRect)calculateIndicatorFrame
{
    //itemCount-1
    NSInteger itemCount =[self.dataSource numberOfItemsInCarousel:self];
    CGFloat indicatorViewWidth =itemCount*indicatorWidth + (itemCount -0.5)*indicatorSpace;
    float x =(self.frame.size.width -  indicatorViewWidth)/2.0f;
    float y = self.frame.size.height -indicatorButtomToScreen;
    CGRect indicatorFrame = CGRectMake(x,y, indicatorViewWidth, indicatorWidth);
    return indicatorFrame;
}

#pragma mark--> iCarousel 代理方法
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_dataSource numberOfItemsInCarousel:self];
}

-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    self.indicatorView.currentActiveItemIndex = carousel.currentItemIndex;
    [self.indicatorView setNeedsDisplay];

}

-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.9f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    return CATransform3DTranslate(transform, offset * self.carouselView.itemWidth * 1.11, 0.0, 0.0);
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    [_delegate carousel:self didSelectItemAtIndex:index];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    return [_dataSource carousel:self viewForItemAtIndex:index reusingView:view];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}


@end


@implementation IndicatorView

-(instancetype)initWithItemCount:(NSInteger)itemCount andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeCenter;
        _itemCount = itemCount;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    if (self.itemCount != 0) {
        for (int i=0; i<self.itemCount; i++) {
            [self drawCircle:i];
        }
    }
}


//画指示器的圆
-(void)drawCircle:(NSInteger)itemIndex
{
    
    CGPoint center;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    if (itemIndex == 0) {
        center.x = indicatorWidth/2.0f;
    }else{
        center.x = indicatorWidth/2.0f + (itemIndex * indicatorSpace) + (itemIndex * indicatorWidth);
    }
    
    center.y = indicatorWidth/2.0f;
    float radius = indicatorWidth/2.0f;
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI*2.0 clockwise:NO];
    //指示器的颜色
    if (itemIndex == _currentActiveItemIndex) {
//        [[UIColor cor] setFill];
        [[UIColor blueColor]setFill];
    }else{
        [[UIColor lightGrayColor] setFill];
    }
    [path fill];
}



@end


