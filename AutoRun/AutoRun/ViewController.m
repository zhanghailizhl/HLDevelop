//
//  ViewController.m
//  AutoRun
//
//  Created by zhangjinkeji on 2018/6/1.
//  Copyright © 2018年 zhangjinkeji. All rights reserved.
//

#import "ViewController.h"
#import "LGJAutoRunLabel.h"
#import "NSString+Engine.h"

#import "RRRRRRR.h"
@interface ViewController ()<LGJAutoRunLabelDelegate>
{
    LGJAutoRunLabel *_runLabel;
    
    UILabel *_marqueeLabel;
    /** 控制跑马灯的timer */
    NSTimer *_timer;
}
@property (nonatomic, strong) NSTimer *timer; //定时器
@property (nonatomic, weak) UIView *viewAnima; //Label的背景
@property (nonatomic, weak) UILabel *customLabel; //Label
@property (nonatomic, strong) NSString *marqueeText; //Label
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self createAutoRunLabel];
    
//    [self addClildView];
//    [self setTimer];
    
//    RRRRRRR* testLabel = [[RRRRRRR alloc] initWithFrame:CGRectMake(100, 300, 180, 21)];
//    // 设置滚动速度
//    testLabel.speed = 0.6;
//    [self.view addSubview:testLabel];
//
    NSString *str = @"0.1你好";
    NSLog(@"%d",[self isPureNumber:str]);
    if ([self isPureNumber:str]) {
        NSLog(@"整数或浮点数");
    }else{
        NSLog(@"非整数，非浮点数");
    }
    
   
   
    
    // marquee label
    _marqueeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    [self.view addSubview:_marqueeLabel];
    _marqueeLabel.textColor = [UIColor redColor];
    _marqueeLabel.font = [UIFont systemFontOfSize:13];
    
}

//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
//判断是否是纯数字
- (BOOL)isPureNumber:(NSString*)string{
    if ([self isPureInt:string] || [self isPureFloat:string]) {
        return YES;
    }
    return NO;
}

#pragma mark - 赋值跑马灯文字
///** 赋值跑马灯文字 */
//- (void)setMarqueeText:(NSString *)marqueeText {
//    _marqueeText = marqueeText;
//
//    _marqueeLabel.text = _marqueeText;
//    [_marqueeLabel sizeToFit];
//    _marqueeLabel.center.Y = self.height / 2;
//
//    if (_timer) {
//        [_timer invalidate];
//        _timer = nil;
//    }
//
//    // 从最右边开始跑
//    _marqueeLabel.x = self.width - 41 - 38;
//
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshMarqueeLabelFrame) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//}
///** 刷新跑马灯label的位置 */
//- (void)refreshMarqueeLabelFrame {
//    _marqueeLabel.x -= 0.3;
//    if (_marqueeLabel.maxX <= 0) {
//        _marqueeLabel.x = self.width - 41 - 38;
//    }
//}
- (void)addClildView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat viewX = (self.view.frame.size.width-200)/2;
    UIView *viewAnima = [[UIView alloc] initWithFrame:CGRectMake(viewX, 100, 200, 40)];
    viewAnima.backgroundColor = [UIColor  yellowColor];
    self.viewAnima = viewAnima;
    self.viewAnima.clipsToBounds = YES; //剪掉超出view范围部分
    
    CGFloat customLabelY = (self.viewAnima.frame.size.height-30)/2;
    UILabel *customLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, customLabelY, 200, 30)];
    customLabel.text = @"跑马灯效果，滚动文本！跑马灯效果，滚动文本！跑马灯效果，滚动文本！跑马灯效果，滚动文本！跑马灯效果，滚动文本！跑马灯效果，滚动文本！跑马灯效果，滚动文本！跑马灯效果，滚动文本！*****";
    customLabel.textColor = [UIColor redColor];
    [customLabel sizeToFit];
    self.customLabel = customLabel;
    
    [self.view addSubview:viewAnima];
    [viewAnima addSubview:customLabel];
}

- (void)setTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changePos) userInfo:nil repeats:YES];
}

- (void)changePos {
    
    CGPoint cenPos = self.customLabel.center;
    
    NSLog(@"cenPos.x %f",cenPos.x);
    if (cenPos.x < -100) {
        
        CGFloat distance = self.customLabel.frame.size.width/2;
        self.customLabel.center = CGPointMake(self.viewAnima.frame.size.width+distance, 20);
    } else {
        self.customLabel.center = CGPointMake(cenPos.x-5, 20);
    }
}


- (void)createAutoRunLabel {
    _runLabel = [[LGJAutoRunLabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    _runLabel.delegate = self;
    _runLabel.speed = 2.0f;
    _runLabel.directionType = LeftType;
    [self.view addSubview:_runLabel];
    [_runLabel addContentView:[self createLabelWithText:@"繁华声 遁入空门 折煞了梦偏冷 辗转一生 情债又几 如你默认 生死枯等 枯等一圈 又一圈的 浮图塔 断了几层 断了谁的痛直奔 一盏残灯 倾塌的山门 容我再等 历史转身 等酒香醇 等你弹 一曲古筝繁华声 遁入空门 折煞了梦偏冷 辗转一生 情债又几 如你默认 生死枯等 枯等一圈 又一圈的 浮图塔 断了几层 断了谁的痛直奔 一盏残灯 倾塌的山门 容我再等 历史转身 等酒香醇 等你弹 一曲古筝繁华声 遁入空门 折煞了梦偏冷 辗转一生 情债又几 如你默认 生死枯等 枯等一圈 又一圈的 浮图塔 断了几层 断了谁的痛直奔 一盏残灯 倾塌的山门 容我再等 历史转身 等酒香醇 等你弹 一曲古筝繁华声 遁入空门 折煞了梦偏冷 辗转一生 情债又几 如你默认 生死枯等 枯等一圈 又一圈的 浮图塔 断了几层 断了谁的痛直奔 一盏残灯 倾塌的山门 容我再等 历史转身 等酒香醇 等你弹 一曲古筝一盏残灯 倾塌的山门 容我再等 历史转身 等酒香醇 等你弹 一曲古筝一盏残灯 倾塌的山门 容我再等再等再" textColor:[UIColor                                                                                                                                                              redColor] labelFont:[UIFont systemFontOfSize:14]]];
    [_runLabel startAnimation];

    UIButton *startRun = [UIButton buttonWithType:UIButtonTypeCustom];
    startRun.frame =CGRectMake(30, 200, 60, 40);
    startRun.backgroundColor = [UIColor greenColor];
    [startRun setTitle:@"start" forState:UIControlStateNormal];
    [startRun addTarget:self action:@selector(startRun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startRun];
    
    UIButton *stopRun = [UIButton buttonWithType:UIButtonTypeCustom];
    stopRun.frame =CGRectMake(120, 200, 60, 40);
    stopRun.backgroundColor = [UIColor redColor];
    [stopRun setTitle:@"stop" forState:UIControlStateNormal];
    [stopRun addTarget:self action:@selector(stopRun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopRun];
    
}
-(void)startRun{
    [_runLabel startAnimation];

}
-(void)stopRun{
    [_runLabel stopAnimation];
}
- (UILabel *)createLabelWithText: (NSString *)text textColor:(UIColor *)textColor labelFont:(UIFont *)font {
    NSString *stringSS = [NSString stringWithFormat:@"%@", text];
    CGFloat width = [stringSS stringOfwidthWithFont:font];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    label.font = font;
    label.text = stringSS;
    label.textColor = textColor;
    return label;
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
}

- (CGFloat)randomValue {
    return arc4random()%255 / 255.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
