//
//  CircleView.m
//  pieDemo
//
//  Created by 宋飞龙 on 16/4/7.
//  Copyright © 2016年 宋飞龙. All rights reserved.
//

#import "CircleView.h"

@interface CircleView () {
    //数值数组
    NSArray * itemsData;
    //颜色数组
    NSArray * colorsData;
}

@property (nonatomic , assign) CGFloat total;
@property (nonatomic , strong) CAShapeLayer * bgCircleLayer;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)itemsArr:(NSArray *)itemsArr
       colorsArr:(NSArray *)colorsArr {
    itemsData = itemsArr;
    colorsData = colorsArr;
    [self makeView];
}

- (void)makeView {
    CGFloat centerWidth = self.frame.size.width * 0.5f;
    CGFloat centerHeight = self.frame.size.height * 0.5f;
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radiusBasic = centerWidth > centerHeight ? centerHeight : centerWidth;
    
    //1.计算红绿蓝部分总和
    _total = 0.0f;
    for (int i = 0; i < itemsData.count; i++) {
        _total += [itemsData[i] floatValue];
    }
    
    //线的半径为扇形半径的一半，线宽是扇形半径，这样就能画出圆形了
    //2.背景路径
    CGFloat bgRadius = radiusBasic * 0.5;
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                          radius:bgRadius
                                                      startAngle:-M_PI_2
                                                        endAngle:M_PI_2 * 3
                                                       clockwise:YES];
    _bgCircleLayer = [CAShapeLayer layer];
    _bgCircleLayer.fillColor   = [UIColor clearColor].CGColor;
    _bgCircleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    _bgCircleLayer.strokeStart = 0.0f;
    _bgCircleLayer.strokeEnd   = 1.0f;
    //层级关系
    _bgCircleLayer.zPosition   = 1;
    _bgCircleLayer.lineWidth   = bgRadius*2;
    _bgCircleLayer.path        = bgPath.CGPath;
    //[self.layer addSublayer:_bgCircleLayer];
    self.layer.mask = _bgCircleLayer;
    //3.绘制扇形
    //3.子扇区路径
    CGFloat otherRadius = radiusBasic * 0.5;
    UIBezierPath *otherPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                             radius:otherRadius
                                                         startAngle:-M_PI_2
                                                           endAngle:M_PI_2 * 3
                                                          clockwise:YES];
    
    CGFloat start = 0.0f;
    CGFloat end = 0.0f;
    for (int i = 0; i < itemsData.count; i++) {
        //4.计算当前end位置 = 上一个结束位置 + 当前部分百分比
        end = [itemsData[i] floatValue] / _total + start;
        
        //图层
        CAShapeLayer *pie = [CAShapeLayer layer];
        [self.layer addSublayer:pie];
        pie.fillColor   = [UIColor clearColor].CGColor;
        if (i > colorsData.count - 1 || !colorsData  || colorsData.count == 0) {//如果传过来的颜色数组少于item个数则随机填充颜色
            pie.strokeColor = [UIColor redColor].CGColor;
        } else {
            pie.strokeColor = ((UIColor *)colorsData[i]).CGColor;
        }
        pie.strokeStart = start;
        pie.strokeEnd   = end;
        pie.lineWidth   = otherRadius * 2.0f;
        pie.zPosition   = 2;
        pie.path        = otherPath.CGPath;
        //计算下一个start位置 = 当前end位置
        start = end;
    }
    //4.白色图层路径
    CGFloat topBgRadius = (radiusBasic-20) * 0.5;
    UIBezierPath *topBgPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                          radius:topBgRadius
                                                      startAngle:-M_PI_2
                                                        endAngle:M_PI_2 * 3
                                                       clockwise:YES];
    CAShapeLayer * topBgLayer = [CAShapeLayer layer];
    topBgLayer.fillColor   = [UIColor clearColor].CGColor;
    topBgLayer.strokeColor = [UIColor whiteColor].CGColor;
    topBgLayer.strokeStart = 0.0f;
    topBgLayer.strokeEnd   = 1.0f;
    topBgLayer.zPosition   = 3;
    topBgLayer.lineWidth   = topBgRadius*2;
    topBgLayer.path        = topBgPath.CGPath;
    [self.layer addSublayer:topBgLayer];
    [self stroke];
}

//划线
- (void)stroke {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration  = 1;
    animation.fromValue = @0.0f;
    animation.toValue   = @1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    [_bgCircleLayer addAnimation:animation forKey:@"circleAnimation"];
}

@end
