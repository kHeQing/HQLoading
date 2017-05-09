//
//  HQLoading.h
//  HQLoadingDemo
//
//  Created by zfwlxt on 17/5/9.
//  Copyright © 2017年 何晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQLoading : UIView

- (void)start;
- (void)stop;

+ (void)showInView:(UIView *)view;
+ (void)hideInView:(UIView *)view;

@end
