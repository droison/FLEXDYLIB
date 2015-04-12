//
//  FLEXDYLIB.m
//  FLEXDYLIB
//
//  Created by 淞 柴 on 15/3/2.
//  Copyright (c) 2015年 song. All rights reserved.
//

#import "FLEXDYLIB.h"
#import <UIKit/UIKit.h>
#import "FLEXManager.h"

/**
 现在默认编译为dylib，用于越狱使用，变以前要安装iOSOpenDev，如果只在某些app自行使用
 可以将proj文件中com.apple.product-type.library.dynamic 改为 com.apple.product-type.framework
 具体参见my blog: http://www.billchai.xyz/zi-ji-dong-shou-zai-xcode6xia-bian-xie-dylibdong-tai-ku-wen-jian.html
 工程目录有一个我编译好的framework，避免每次都自己设
 */

@implementation FLEXDYLIB

- (id)init
{
    self = [super init];
    if (self) {
        isInit = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appLaunched:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)appLaunched:(NSNotification *)notification
{
    if (isInit) {
        return;
    }
    NSLog(@"======================= libFlex dylib show ========================");
    UIWindow* window = [[UIApplication sharedApplication].delegate window];
    if (window) {
        UISwipeGestureRecognizer* ges = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction:)];
        ges.direction = UISwipeGestureRecognizerDirectionDown;
        ges.numberOfTouchesRequired = 3;
        [window addGestureRecognizer:ges];
        isInit = YES;
    }
}

- (void)swipeGestureAction:(UISwipeGestureRecognizer*)ges
{
    [[FLEXManager sharedManager] showExplorer];
}

@end

static void __attribute__((constructor)) initialize(void)
{
    NSLog(@"======================= libFlex dylib initialize ========================");
    
    static FLEXDYLIB *entrance;
    entrance = [[FLEXDYLIB alloc] init];
}