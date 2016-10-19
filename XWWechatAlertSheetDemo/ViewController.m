//
//  ViewController.m
//  XWWechatAlertSheetDemo
//
//  Created by bene on 16/10/19.
//  Copyright © 2016年 bene. All rights reserved.
//

#import "ViewController.h"
#import "XWActionSheetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 50);
    [btn setTitle:@"sheetView" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.center = self.view.center;
}

- (void)btnClick:(UIButton *)btn {
    
    XWActionSheetView *sheetView = [[XWActionSheetView alloc]initWithFrame:self.view.bounds titleArrays:@[@"从相册选择",@"拍照",@"小视频"]];
    sheetView.btnHandler = ^(XWActionSheetView *actionSheetView, NSInteger clickIndex){
        [actionSheetView hiddenSheetView];
        NSLog(@"clickIndex:%ld",(long)clickIndex);
    };
    
    [self.view addSubview:sheetView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
