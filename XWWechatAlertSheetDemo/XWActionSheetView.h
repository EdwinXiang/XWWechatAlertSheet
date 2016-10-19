//
//  XWActionSheetView.h
//  neiku
//
//  Created by bene on 16/10/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWActionSheetView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleArrays:(NSArray *)titleArray;
@property (nonatomic, strong) void(^btnHandler)(XWActionSheetView *actionSheetView, NSInteger clickIndex);
-(void)hiddenSheetView;
@end
