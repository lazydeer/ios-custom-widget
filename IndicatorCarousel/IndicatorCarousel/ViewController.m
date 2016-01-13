//
//  ViewController.m
//  IndicatorCarousel
//
//  Created by Zhiqiang Deng on 16/1/13.
//  Copyright © 2016年 Zhiqiang Deng. All rights reserved.
//

#import "ViewController.h"
#import "IndicatorCarouselView.h"
#import "ZQCardView.h"

@interface ViewController ()<IndicatorCarouselDataSource,IndicatorCarouselDelegate>

@property (nonatomic,strong) IndicatorCarouselView *carouselView;
@property (nonatomic,strong) NSArray * cardsSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-108);
    _carouselView = [[IndicatorCarouselView alloc]initWithFrame:frame];
    _carouselView.delegate = self;
    _carouselView.dataSource = self;
    [self.view addSubview:_carouselView];
}


-(NSArray *)cardsSource
{
    _cardsSource = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    return _cardsSource;
}

-(NSInteger)numberOfItemsInCarousel:(IndicatorCarouselView *)carousel{
    return self.cardsSource.count;
}

-(UIView *)carousel:(IndicatorCarouselView *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    ZQCardView *v = [[ZQCardView alloc]initWithFrame:CGRectMake(0, 0, carousel.itemSize.width, carousel.itemSize.height)];
    
    UITextView *titleText = [[UITextView alloc]initWithFrame:CGRectMake(carousel.itemSize.width/2, carousel.itemSize.height/2, 10, 10)];
    titleText.font = [UIFont systemFontOfSize:18.0f];
    titleText.text = [_cardsSource objectAtIndex:index];
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.userInteractionEnabled = NO;
    titleText.scrollEnabled = NO;
    
    [v addSubview:titleText];
    
    return v;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
