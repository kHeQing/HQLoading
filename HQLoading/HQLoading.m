//
//  HQLoading.m
//  HQLoadingDemo
//
//  Created by zfwlxt on 17/5/9.
//  Copyright © 2017年 何晴. All rights reserved.
//

#import "HQLoading.h"

static CGFloat ballScale = 1.5f;

@interface HQLoading()<CAAnimationDelegate>

{
    UIVisualEffectView *_ballContainer;
    UIView *_ballOne;
    UIView *_ballTwo;
    UIView *_ballThree;
    
    BOOL _stopAnimationByUser;
}

@end

@implementation HQLoading

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _ballContainer = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]];
    _ballContainer.frame = CGRectMake(0, 0, 100, 100);
    _ballContainer.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    _ballContainer.layer.cornerRadius = 10.0f;
    _ballContainer.layer.masksToBounds = YES;
    [self addSubview:_ballContainer];
    
    CGFloat ballWidth = 13.0f;
    CGFloat margin = 3.0f;
    
    _ballOne = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, ballWidth, ballWidth))];
    _ballOne.center = CGPointMake(ballWidth/2.0f + margin, _ballContainer.bounds.size.width/2.0f);
    _ballOne.layer.cornerRadius = ballWidth/2.0f;
    _ballOne.backgroundColor = [UIColor colorWithRed:54/255.0 green:136/255.0 blue:250/255.0 alpha:1];
    [_ballContainer addSubview:_ballOne];
    
    _ballTwo = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, ballWidth, ballWidth))];
    _ballTwo.center = CGPointMake(_ballContainer.bounds.size.width/2.0f, _ballContainer.bounds.size.width/2.0f);
    _ballTwo.layer.cornerRadius = ballWidth/2.0f;
    _ballTwo.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    [_ballContainer addSubview:_ballTwo];
    
    _ballThree = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, ballWidth, ballWidth))];
    _ballThree.center = CGPointMake(_ballContainer.bounds.size.width-ballWidth/2.0f - margin, _ballContainer.bounds.size.width/2.0f);
    _ballThree.layer.cornerRadius = ballWidth/2.0f;
    _ballThree.backgroundColor = [UIColor colorWithRed:234/255.0 green:67/255.0 blue:69/255.0 alpha:1];
    [_ballContainer addSubview:_ballThree];

}

- (void)startPathAnimation{

    // ====第一个球
    CGFloat width = _ballContainer.bounds.size.width;
    // 小圆半径
    CGFloat r = (_ballOne.bounds.size.width)*ballScale/2.0f;
    // 大圆半径
    CGFloat R = (width/2 + r)/2.0f;
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:_ballOne.center];
    // 画大圆
    [path1 addArcWithCenter:CGPointMake(r+R, width/2) radius:R startAngle:M_PI endAngle:M_PI*2 clockwise:NO];
    // 画小圆
    UIBezierPath *path1_1 = [UIBezierPath bezierPath];
    [path1_1 addArcWithCenter:CGPointMake(width/2, width/2) radius:2*r startAngle:M_PI*2 endAngle:M_PI clockwise:NO];
    [path1 appendPath:path1_1];
    // 回到原处
    [path1 addLineToPoint:_ballOne.center];
    // 执行动画
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation1.path = path1.CGPath;
    animation1.removedOnCompletion = YES;
    animation1.duration = [self animationDuratiton];
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_ballOne.layer addAnimation:animation1 forKey:@"animation1"];
    
    //====第三个球的动画
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:_ballThree.center];
    //画大圆
    [path3 addArcWithCenter:CGPointMake(width - (R + r), width/2) radius:R startAngle:2*M_PI endAngle:M_PI clockwise:NO];
    //画小圆
    UIBezierPath *path3_1 = [UIBezierPath bezierPath];
    [path3_1 addArcWithCenter:CGPointMake(width/2, width/2) radius:r*2 startAngle:M_PI endAngle:M_PI*2 clockwise:NO];
    [path3 appendPath:path3_1];
    //回到原处
    [path3 addLineToPoint:_ballThree.center];
    //执行动画
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation3.path = path3.CGPath;
    animation3.removedOnCompletion = YES;
    animation3.duration = [self animationDuratiton];
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation3.delegate = self;
    [_ballThree.layer addAnimation:animation3 forKey:@"animation3"];
}

// 缩放动画
- (void)animationDidStart:(CAAnimation *)anim{
    
    CGFloat delay = 0.3f;
    CGFloat duration = [self animationDuratiton]/2 - delay;
    
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        _ballOne.transform = CGAffineTransformMakeScale(ballScale, ballScale);
        _ballTwo.transform = CGAffineTransformMakeScale(ballScale, ballScale);
        _ballThree.transform = CGAffineTransformMakeScale(ballScale, ballScale);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            _ballOne.transform = CGAffineTransformIdentity;
            _ballTwo.transform = CGAffineTransformIdentity;
            _ballThree.transform = CGAffineTransformIdentity;
            
        } completion:nil];
    }];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (_stopAnimationByUser) {
        return;
    }
    [self startPathAnimation];
}

- (CGFloat)animationDuratiton{
    return 1.6f;
}


#pragma mark -
#pragma mark 显示隐藏方法
-(void)start{
    [self startPathAnimation];
    _stopAnimationByUser = false;
}

-(void)stop{
    _stopAnimationByUser = true;
    [_ballOne.layer removeAllAnimations];
    [_ballOne removeFromSuperview];
    [_ballTwo.layer removeAllAnimations];
    [_ballTwo removeFromSuperview];
    [_ballTwo.layer removeAllAnimations];
    [_ballTwo removeFromSuperview];
}

+ (void)showInView:(UIView *)view{

    [self hideInView:view];
    HQLoading *loading = [[HQLoading alloc]initWithFrame:view.bounds];
    [view addSubview:loading];
    [loading start];
    
}

+ (void)hideInView:(UIView *)view{

    for (HQLoading *loading in view.subviews) {
        if ([loading isKindOfClass:[HQLoading class]]) {
            [loading stop];
            [loading removeFromSuperview];
        }
    }
}


@end
