//
//  RRRRRRR.m
//  AutoRun
//
//  Created by zhangjinkeji on 2018/6/1.
//  Copyright © 2018年 zhangjinkeji. All rights reserved.
//

#import "RRRRRRR.h"
@interface RRRRRRR()<CAAnimationDelegate>
{
    CGFloat _width;
    CGFloat _height;
    CGFloat _animationViewWidth;
    CGFloat _animationViewHeight;
    BOOL _stoped;
    UIView *_contentView;//滚动内容视图
}
@property (nonatomic, strong) UIView *animationView;//放置滚动内容视图
@end
@implementation RRRRRRR

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        _width = frame.size.width;
        _height = frame.size.height;
        
        self.layer.masksToBounds = YES;
        self.animationView = [[UIView alloc] initWithFrame:CGRectMake(_width, 0, _width, _height)];
        [self addSubview:self.animationView];
        
        
        NSInteger space = 5;
        UILabel* contentLabel = [[UILabel alloc] init];
        // 设置基本属性
        contentLabel.text = @"我不想说再见,不说再见,越长大越孤单";
        contentLabel.textColor = [UIColor redColor];
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.backgroundColor = [UIColor grayColor];
        [contentLabel sizeToFit];
        contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel = contentLabel;
        [self addSubview:self.contentLabel];
        CAShapeLayer* maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        self.layer.mask = maskLayer;
        
        CAKeyframeAnimation* keyFrame = [CAKeyframeAnimation animation];
        keyFrame.keyPath = @"transform.translation.x";
        keyFrame.values = @[@(0), @(-space), @(0)];
        keyFrame.repeatCount = NSIntegerMax;
        keyFrame.duration = self.speed * self.contentLabel.text.length;
        keyFrame.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.5 :0.5]];
        keyFrame.delegate = self;
        [self.contentLabel.layer addAnimation:keyFrame forKey:nil];

    }
    return self;
}


@end
