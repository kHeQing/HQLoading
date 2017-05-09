//
//  ViewController.m
//  HQLoadingDemo
//
//  Created by zfwlxt on 17/5/9.
//  Copyright © 2017年 何晴. All rights reserved.
//

#import "ViewController.h"
#import "HQLoading.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"显示" style:(UIBarButtonItemStylePlain) target:self action:@selector(show)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"隐藏" style:(UIBarButtonItemStylePlain) target:self action:@selector(hide)];
    
    [HQLoading showInView:self.view];
}

- (void)show{

    [HQLoading showInView:self.view];
    
}

- (void)hide{

    [HQLoading hideInView:self.view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
