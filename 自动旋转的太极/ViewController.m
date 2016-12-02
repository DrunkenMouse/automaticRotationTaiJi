//
//  ViewController.m
//  自动旋转的太极
//
//  Created by 王奥东 on 16/12/1.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "TaiJiView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TaiJiView *taiji = [[TaiJiView alloc] initWithFrame:CGRectMake(50.0f, 80.0f, 230.0f, 320.0f)];
    [self.view addSubview:taiji];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
