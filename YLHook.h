//
//  YLHook.h
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"

@interface YLHookEvent : NSObject
@property (nonatomic, assign, readonly) AspectOptions option;
@property (nonatomic, copy, readonly) id handlerBlock;
@property (nonatomic, readonly) SEL hookSelector;

- (YLHookEvent *(^)(NSString *selectorName))selector;
- (YLHookEvent *(^)(id blk))block;
- (YLHookEvent *)after;
- (YLHookEvent *)instead;
- (YLHookEvent *)before;
- (YLHookEvent *)automaticRemoval;
- (YLHookEvent *)execute;
@end


@interface YLHookEventMaker : NSObject
- (YLHookEvent *(^)(NSString *selectorName))selector;
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
