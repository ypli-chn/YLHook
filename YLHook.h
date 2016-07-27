//
//  YLHook.h
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

#define YL_HELPER_0(x) #x
#define YL_HELPER_1(x) YL_HELPER_0(clang diagnostic ignored #x)
#define YL_CLANG_WARNING(x) _Pragma(YL_HELPER_1(x))

#define sel(SELECTOR)  selector(\
_Pragma("clang diagnostic push")    \
YL_CLANG_WARNING(-Wundeclared-selector) \
@selector(SELECTOR) \
_Pragma("clang diagnostic pop")\
)

@interface YLHookEvent : NSObject
@property (nonatomic, assign, readonly) AspectOptions option;
@property (nonatomic, copy, readonly) id handlerBlock;
@property (nonatomic, readonly) SEL hookSelector;

- (YLHookEvent *(^)(SEL selector))selector;
- (YLHookEvent *(^)(id blk))block;
- (YLHookEvent *)after;
- (YLHookEvent *)instead;
- (YLHookEvent *)before;
- (YLHookEvent *)automaticRemoval;
- (YLHookEvent *)execute;
@end


@interface YLHookEventMaker : NSObject
- (YLHookEvent *)after;
- (YLHookEvent *)instead;
- (YLHookEvent *)before;
- (YLHookEvent *)automaticRemoval;
- (NSArray<YLHookEvent *> *)events;
@end


@interface YLHook : NSObject
+ (YLHook *)hookClass:(Class)cls;
+ (YLHook *)hookClassByName:(NSString *)name;
+ (YLHook *)hookInstance:(id)instance;

- (void)makeEvents:(void (^)(YLHookEventMaker *make))block;
- (void)makeEvents:(void (^)(YLHookEventMaker *make))block catch:(void (^)(NSError *error))errorBlock;
@end


@interface NSObject (YLHook)
- (void)yl_makeEvents:(void (^)(YLHookEventMaker *make))block;
- (void)yl_makeEvents:(void (^)(YLHookEventMaker *make))block catch:(void (^)(NSError *error))errorBlock;

+ (void)yl_makeEvents:(void (^)(YLHookEventMaker *make))block;
+ (void)yl_makeEvents:(void (^)(YLHookEventMaker *make))block catch:(void (^)(NSError *error))errorBlock;
@end
