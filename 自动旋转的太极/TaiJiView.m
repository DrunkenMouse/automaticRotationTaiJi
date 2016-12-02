//
//  TaiJiView.m
//  自动旋转的太极
//
//  Created by 王奥东 on 16/12/1.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "TaiJiView.h"

@implementation TaiJiView {
    NSTimer * _timer;
    float _currentIndex;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _currentIndex = 0.0;
        self.backgroundColor = [UIColor clearColor];
       
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/32.0f target:self selector:@selector(updateSpotlight) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)updateSpotlight {
    
    _currentIndex += 0.01;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
    
    //圆心
    float x = self.frame.size.width / 2;
    float y = self.frame.size.height / 2;
    //半径
    float radius = self.frame.size.width / 2;
    if (self.frame.size.width > self.frame.size.height) {
    
        radius = self.frame.size.height / 2;
    }
    //当前比例乘180°
    float runAngle = M_PI * _currentIndex;
    //画了一个圆，就从0度开始画
    if (runAngle >= 2 * M_PI) {
        runAngle -= 2 * M_PI;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //使用RGB A来生成颜色，如果直接WhiteColor则会出现颜色不显示等情况
    //具体原因po的时候即可发现
    CGColorRef  whiteColor =[[UIColor colorWithRed:1 green:1 blue:1 alpha:1] CGColor];
    CGColorRef  blackColor =[[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor];
    
    //CGColorGetComponents获取入参颜色的组成，来设置为填充色
    CGContextSetFillColor(context, CGColorGetComponents(whiteColor));
    
    /**
     在上下文的路径中添加一个圆弧，可能前面加上一个直线段。 `（x，y）'是圆弧的中心; `radius'是它的半径; `startAngle'是弧的第一个端点的角度; `endAngle'是弧的第二个端点的角度; 和如果顺时针绘制圆弧，“顺时针”为1，否则为0。
         `startAngle'和'endAngle'以弧度表示。
     180°为半圆弧
     */
    CGContextAddArc(context, x, y, radius, 0+runAngle, M_PI+runAngle, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    //画黑色
    CGContextSetFillColor(context, CGColorGetComponents(blackColor));
    CGContextAddArc(context, x, y, radius, M_PI+runAngle, M_PI*2+runAngle, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    //画白色圆弧
    CGContextSetFillColor(context, CGColorGetComponents(whiteColor));
    CGContextAddArc(context, x+radius/2*cos(runAngle), y+radius/2*sin(runAngle), radius/2, M_PI+runAngle, M_PI*2+runAngle, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    //画黑色圆弧
    CGContextSetFillColor(context, CGColorGetComponents(blackColor));
    CGContextAddArc(context, x-radius/2 * cos(runAngle), y - radius/2*sin(runAngle), radius/2, 0+runAngle, M_PI+runAngle, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    //设置白色的线，遮盖白色半圆弧中的黑色线
    CGContextSetStrokeColorWithColor(context, whiteColor);
    CGContextMoveToPoint(context, x+radius*cos(runAngle), y+radius*sin(runAngle));
    CGContextAddLineToPoint(context, x, y);
    CGContextStrokePath(context);
    
    //设置黑色的线，遮盖住黑色半圆弧中的白色线
    CGContextSetStrokeColorWithColor(context, blackColor);
    CGContextMoveToPoint(context, x-radius * cos(runAngle), y-radius*sin(runAngle));
    CGContextAddLineToPoint(context, x, y);
    CGContextStrokePath(context);

   //画白色小圆
    CGContextSetFillColor(context, CGColorGetComponents(whiteColor));
    CGContextAddArc(context, x-radius/2*cos(runAngle), y-radius/2*sin(runAngle), radius/4, 0, M_PI*2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    //画黑色小圆
    CGContextSetFillColor(context, CGColorGetComponents(blackColor));
    CGContextAddArc(context, x+radius/2*cos(runAngle), y+radius/2*sin(runAngle), radius/4, 0, M_PI*2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
}


@end
