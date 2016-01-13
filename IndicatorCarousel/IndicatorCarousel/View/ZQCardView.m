//
//  ZQCardView.m
//  HBBForPrincipal
//
//  Created by Zhiqiang Deng on 16/1/5.
//  Copyright © 2016年 HXKid. All rights reserved.
//

#import "ZQCardView.h"

@implementation ZQCardView



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void) layoutSubviews {
    [super layoutSubviews];//is must to ensure rightly layout children view
    
    //1. first, create Inner layer with content
    CALayer *innerView = [CALayer layer];
    innerView.frame = CGRectMake(5,5,self.bounds.size.width-10,self.bounds.size.height-10);
    //instead of: innerView.frame = self.frame;
    innerView.borderWidth = 1.0f;
    innerView.cornerRadius = 6.0f;
    innerView.masksToBounds = YES;
    
    innerView.borderColor = [[UIColor colorWithRed:0xdc green:0xdc blue:0xdc alpha:0x0] CGColor];
    innerView.backgroundColor = [[UIColor whiteColor] CGColor];
    //put the layer to the BOTTOM of layers is also a MUST step...
    //otherwise this layer will overlay the sub uiviews in current uiview...
    [self.layer insertSublayer:innerView atIndex:0];
    
    //2. then, create shadow with self layer
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [[UIColor grayColor] CGColor];
    self.layer.shadowOpacity = 0.4f;
    //shadow length
    self.layer.shadowRadius = 2.0f;
    //no offset
    self.layer.shadowOffset = CGSizeMake(0, 0);
    //right down shadow
    //[self.layer setShadowOffset: CGSizeMake(1.0f, 1.0f)];
    
    //3. last but important, MUST clear current view background color, or the color will show in the corner!
    self.backgroundColor = [UIColor clearColor];
}


@end
