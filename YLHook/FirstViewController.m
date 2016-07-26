//
//  ViewController.m
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "FirstViewController.h"
#import "YLHook.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self yl_makeEvents:^(YLHookEventMaker *make) {
        make.after.selector(@"viewDidAppear:").block(^(id<AspectInfo> aspectInfo){
             NSLog(@"[%@]after viewDidAppear",[[aspectInfo instance] class]);
        });
    }];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
