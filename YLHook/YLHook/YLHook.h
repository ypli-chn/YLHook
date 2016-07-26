//
//  YLHook.h
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLEventMaker.h"

@interface YLHook : NSObject
+ (YLHook *)hookClass:(Class)cls;
+ (YLHook *)hookClassByName:(NSString *)name;

+ (YLHook *)hookInstance:(id)instance;
- (void)makeEvents:(void (^)(YLEventMaker *make))block;
- (void)makeEvents:(void (^)(YLEventMaker *make))block catch:(void (^)(NSError *error))errorBlock;
@end
