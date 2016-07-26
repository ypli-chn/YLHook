//
//  NSObject+YLHook.h
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLHook.h"

@interface NSObject (YLHook)
- (void)yl_makeEvents:(void (^)(YLEventMaker *make))block;
- (void)yl_makeEvents:(void (^)(YLEventMaker *make))block catch:(void (^)(NSError *error))errorBlock;

+ (void)yl_makeEvents:(void (^)(YLEventMaker *make))block;
+ (void)yl_makeEvents:(void (^)(YLEventMaker *make))block catch:(void (^)(NSError *error))errorBlock;
@end
