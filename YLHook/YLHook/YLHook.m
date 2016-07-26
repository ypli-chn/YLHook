//
//  YLHook.m
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "YLHook.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
@interface YLHook()

@property (nonatomic, strong) YLEventMaker *make;
@property (nonatomic, strong) Class cls;
@property (nonatomic, strong) id instance;
@end
@implementation YLHook
#pragma mark - Public API
+ (YLHook *)hookClass:(Class)cls {
    YLHook *hook = [[YLHook alloc]init];
    hook.cls = cls;
    hook.make = [[YLEventMaker alloc] init];
    return hook;
}

+ (YLHook *)hookClassByName:(NSString *)name {
    Class cls = NSClassFromString(name);
    return [self hookClass:cls];
}


+ (YLHook *)hookInstance:(id)instance {
    YLHook *hook = [[YLHook alloc]init];
    hook.instance = instance;
    hook.make = [[YLEventMaker alloc] init];
    return hook;
}

- (void)makeEvents:(void (^)(YLEventMaker *))block {
    [self makeEvents:block catch:nil];
}

- (void)makeEvents:(void (^)(YLEventMaker *make))block catch:(void (^)(NSError *error))errorBlock {
    block(self.make);
    NSError *error = [self execute];
    if(errorBlock) {
        errorBlock(error);
    }
}

#pragma mark - hook
- (NSError *)execute {
    __weak YLHook *weakSelf = self;
    __block NSError *error = nil;
    if (self.instance == nil) {
        [self.make.events enumerateObjectsUsingBlock:^(YLEvent * _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakSelf.cls aspect_hookSelector:event.hookSelector
                                  withOptions:event.option
                                   usingBlock:event.handlerBlock
                                        error:&error];
            if (error) {
                *stop = YES;
            }
        }];
    } else {
        [self.make.events enumerateObjectsUsingBlock:^(YLEvent * _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakSelf.instance aspect_hookSelector:event.hookSelector
                                  withOptions:event.option
                                   usingBlock:event.handlerBlock
                                        error:&error];
            if (error) {
                *stop = YES;
            }
        }];
    }
    return error;
}

@end
