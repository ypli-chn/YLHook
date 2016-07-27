//
//  YLHook.m
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "YLHook.h"
#import <objc/runtime.h>

#pragma mark - YLHookEvent
/*************************************************************
 *                  YLHookEvent
 *************************************************************/
@interface YLHookEvent()
@property (nonatomic, assign) AspectOptions option;
@property (nonatomic, copy) id handlerBlock;
@property (nonatomic) SEL hookSelector;
@end
@implementation YLHookEvent
- (YLHookEvent *)after {
    self.option = AspectPositionAfter;
    return self;
}

- (YLHookEvent *)instead {
    self.option = AspectPositionInstead;
    return self;
}

- (YLHookEvent *)before {
    self.option = AspectPositionBefore;
    return self;
}

- (YLHookEvent *)automaticRemoval {
    self.option = AspectOptionAutomaticRemoval;
    return self;
}

- (YLHookEvent *(^)(SEL selector))selector {
    return ^id(SEL selector) {
        self.hookSelector = selector;
        return self;
    };
}

- (YLHookEvent *(^)(id blk))block {
    return ^id(id blk) {
        self.handlerBlock = blk;
        return self;
    };
}

- (YLHookEvent *)execute {
    return self;
}

@end

#pragma mark - YLHookEventMaker
/*************************************************************
 *                  YLHookEventMaker
 *************************************************************/
@interface YLHookEventMaker()
@property (nonatomic, strong) NSMutableSet<YLHookEvent *>* madeEvents;
@end
@implementation YLHookEventMaker


- (YLHookEvent *)after {
    return self.generateEvent.after;
}
- (YLHookEvent *)instead {
    return self.generateEvent.instead;
}
- (YLHookEvent *)before {
    return self.generateEvent.before;
}
- (YLHookEvent *)automaticRemoval {
    return self.generateEvent.automaticRemoval;
}

- (YLHookEvent *)generateEvent {
    YLHookEvent *event = [[YLHookEvent alloc] init];
    [self.madeEvents addObject:event];
    return event;
}


- (NSMutableSet<YLHookEvent *> *)madeEvents {
    if (_madeEvents == nil) {
        _madeEvents = [[NSMutableSet alloc] init];
    }
    return _madeEvents;
}

- (NSArray<YLHookEvent *> *)events {
    return [self.madeEvents allObjects];
}
@end


#pragma mark - YLHook
/*************************************************************
 *                  YLHook
 *************************************************************/

@interface YLHook()

@property (nonatomic, strong) YLHookEventMaker *make;
@property (nonatomic, strong) Class cls;
@property (nonatomic, strong) id instance;
@end
@implementation YLHook
#pragma mark Public API
+ (YLHook *)hookClass:(Class)cls {
    YLHook *hook = [[YLHook alloc]init];
    hook.cls = cls;
    hook.make = [[YLHookEventMaker alloc] init];
    return hook;
}

+ (YLHook *)hookClassByName:(NSString *)name {
    Class cls = NSClassFromString(name);
    return [self hookClass:cls];
}


+ (YLHook *)hookInstance:(id)instance {
    YLHook *hook = [[YLHook alloc]init];
    hook.instance = instance;
    hook.make = [[YLHookEventMaker alloc] init];
    return hook;
}

- (void)makeEvents:(void (^)(YLHookEventMaker *))block {
    [self makeEvents:block catch:nil];
}

- (void)makeEvents:(void (^)(YLHookEventMaker *make))block catch:(void (^)(NSError *error))errorBlock {
    block(self.make);
    
    NSError *error = [self execute];
    if(errorBlock) {
        errorBlock(error);
    }
}


#pragma mark hook
- (NSError *)execute {
    __block NSError *error = nil;
    if (self.instance == nil) {
        [self.make.events enumerateObjectsUsingBlock:^(YLHookEvent * _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cls aspect_hookSelector:event.hookSelector
                              withOptions:event.option
                               usingBlock:event.handlerBlock
                                    error:&error];
            if (error) {
                *stop = YES;
            }
        }];
    } else {
        [self.make.events enumerateObjectsUsingBlock:^(YLHookEvent * _Nonnull event, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.instance aspect_hookSelector:event.hookSelector
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

#pragma mark -  NSObject (YLHook)
/*************************************************************
 *                   NSObject (YLHook)
 *************************************************************/


@implementation NSObject (YLHook)
- (void)yl_makeEvents:(void (^)(YLHookEventMaker *make))block {
    [[YLHook hookInstance:self] makeEvents:block];
}

- (void)yl_makeEvents:(void (^)(YLHookEventMaker *make))block catch:(void (^)(NSError *error))errorBlock {
    [[YLHook hookInstance:self] makeEvents:block catch:errorBlock];
}

+ (void)yl_makeEvents:(void (^)(YLHookEventMaker *make))block {
    [[YLHook hookInstance:[self class]] makeEvents:block];
}

+ (void)yl_makeEvents:(void (^)(YLHookEventMaker *make))block catch:(void (^)(NSError *error))errorBlock {
    [[YLHook hookInstance:[self class]] makeEvents:block catch:errorBlock];
}
@end
