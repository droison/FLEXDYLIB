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