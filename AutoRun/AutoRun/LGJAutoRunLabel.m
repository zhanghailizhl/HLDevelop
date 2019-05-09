//
//  LGJAutoRunLabel.m
//  AutoRun
//
//  Created by zhangjinkeji on 2018/6/1.
//  Copyright © 2018年 zhangjinkeji. All rights reserved.
//

#import "LGJAutoRunLabel.h"
@interface LGJAutoRunLabel()<CAAnimationDelegate>
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

@implementation LGJAutoRunLabel
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        _width = frame.size.width;
        _height = frame.size.height;
        
        self.speed = self.speed;
        self.directionType = LeftType;
        self.layer.masksToBounds = YES;
        self.animationView = [[UIView alloc] initWithFrame:CGRectMake(_width, 0, _width, _height)];
        [self addSubview:self.animationView];
    }
    return self;
}

- (void)addContentView:(UIView *)view {
    
    [_contentView removeFromSuperview];
    view.frame = view.bounds;
    _contentView = view;
    self.animationView.frame = view.bounds;
    [self.animationView addSubview:_contentView];
    
    _animationViewWidth = self.animationView.frame.size.width;
    _animationViewHeight = self.animationView.frame.size.height;
}

- (void)startAnimation {
    NSLog(@"########%f",_animationViewWidth / 30.f * (1 / self.speed));
    [self.animationView.layer removeAnimationForKey:@"animationViewPosition"];
    _stoped = NO;
    
    CGPoint pointRightCenter = CGPointMake(_width + _animationViewWidth / 2.f, _animationViewHeight / 2.f);
    CGPoint pointLeftCenter  = CGPointMake(-_animationViewWidth / 2, _animationViewHeight / 2.f);
    CGPoint fromPoint        = self.directionType == LeftType ? pointRightCenter : pointLeftCenter;
    CGPoint toPoint          = self.directionType == LeftType ? pointLeftCenter  : pointRightCenter;
    
    self.animationView.center = fromPoint;
    UIBezierPath *movePath    = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    [movePath addLineToPoint:toPoint];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path                 = movePath.CGPath;
    moveAnimation.removedOnCompletion  = YES;
    moveAnimation.duration             = _animationViewWidth / 30.f * (1 / self.speed);
    moveAnimation.delegate             = self;
    [self.animationView.layer addAnimation:moveAnimation forKey:@"animationViewPosition"];
}

- (void)stopAnimation {
    _stoped = YES;
    [self.animationView.layer removeAnimationForKey:@"animationViewPosition"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.delegate && [self.delegate respondsToSelector:@selector(operateLabel:animationDidStopFinished:)]) {
        [self.delegate operateLabel:self animationDidStopFinished:flag];
    }
    if (flag && !_stoped) {
        [self startAnimation];
    }
}


@end
