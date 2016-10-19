//
//  XWActionSheetView.m
//  neiku
//
//  Created by bene on 16/10/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XWActionSheetView.h"
#import <objc/runtime.h>

static const void *BKBarButtonItemBlockKey = &BKBarButtonItemBlockKey;
@interface XWActionSheetView ()

@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation XWActionSheetView

-(instancetype)initWithFrame:(CGRect)frame titleArrays:(NSArray *)titleArray {
    if (self = [super initWithFrame:frame]) {
        _size = [UIScreen mainScreen].bounds.size;
        [self setBackgroundColor:[UIColor colorWithWhite:0. alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
        [self addGestureRecognizer:tap];
        [self makeBaseUIWithTitleArray:titleArray];
    }
    return self;
}

- (void)makeBaseUIWithTitleArray:(NSArray *)titleArray {
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, _size.height, _size.width, titleArray.count * 50 + 55)];
    _backgroundView.backgroundColor = [UIColor colorWithRed:0xe9/255.0 green:0xe9/255.0 blue:0xe9/255.0 alpha:1.0];
    [self addSubview:_backgroundView];
    
    CGFloat y = [self createBtnWithTitle:@"取消" origin_y: _backgroundView.frame.size.height - 50 tag:-1 action:@selector(hiddenSheetView)] - 55;
    for (int i = 0; i < titleArray.count; i++) {
        y = [self createBtnWithTitle:titleArray[i] origin_y:y tag:i action:@selector(click:)];
    }
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = weakSelf.backgroundView.frame;
        frame.origin.y -= frame.size.height;
        weakSelf.backgroundView.frame = frame;
    }];
}

- (CGFloat)createBtnWithTitle:(NSString *)title origin_y:(CGFloat)y tag:(NSInteger)tag action:(SEL)method {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, y, _size.width, 50);
    btn.backgroundColor = [UIColor whiteColor];
    btn.tag = tag;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:btn];
    return y -= tag == -1 ? 0 : 50.4;
}
- (void)hiddenSheetView {

     __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = weakSelf.backgroundView.frame;
        frame.origin.y += frame.size.height;
        weakSelf.backgroundView.frame = frame;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf removeFromSuperview];
    });
}

- (void)click:(UIButton *)btn {
    if (self.btnHandler) {
        self.btnHandler(self,btn.tag);
    }
}
@end
