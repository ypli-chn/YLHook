//
//  NSObject+YLHook.m
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "NSObject+YLHook.h"

@implementation NSObject (YLHook)
- (void)yl_makeEvents:(void (^)(YLEventMaker *make))block {
    [[YLHook hookInstance:self] makeEvents:block];
}

- (void)yl_makeEvents:(void (^)(YLEventMaker *make))block catch:(void (^)(NSError *error))errorBlock {
    [[YLHook hookInstance:self] makeEvents:block catch:errorBlock];
}

+ (void)yl_makeEvents:(void (^)(YLEventMaker *make))block {
    [[YLHook hookInstance:[self class]] makeEvents:block];
}

+ (void)yl_makeEvents:(void (^)(YLEventMaker *make))block catch:(void (^)(NSError *error))errorBlock {
    [[YLHook hookInstance:[self class]] makeEvents:block catch:errorBlock];
}
@end
