//
//  ViewController.m
//  SliderKVO
//
//  Created by mac on 2018/1/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "ZSHBeautyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZSHBeautyView *beautyView = [[ZSHBeautyView alloc]initWithFrame:CGRectMake(0, 100, 375, 300)];
    [self.view addSubview:beautyView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
