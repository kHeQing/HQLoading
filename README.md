# HQLoading
动画小球的加载

![gif](https://github.com/Whiteands/HQLoading/blob/master/GIF/1.gif)


```
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

```