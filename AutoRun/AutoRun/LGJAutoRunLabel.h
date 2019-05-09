//
//  LGJAutoRunLabel.h
//  AutoRun
//
//  Created by zhangjinkeji on 2018/6/1.
//  Copyright © 2018年 zhangjinkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGJAutoRunLabel;

typedef NS_ENUM(NSInteger, RunDirectionType) {
    LeftType = 0,
    RightType = 1,
};

@protocol LGJAutoRunLabelDelegate <NSObject>

@optional
- (void)operateLabel: (LGJAutoRunLabel *)autoLabel animationDidStopFinished: (BOOL)finished;

@end

@interface LGJAutoRunLabel : UIView

@property (nonatomic, weak) id <LGJAutoRunLabelDelegate> delegate;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) RunDirectionType directionType;

- (void)addContentView: (UIView *)view;
- (void)startAnimation;
- (void)stopAnimation;


@end
