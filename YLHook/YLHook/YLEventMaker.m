//
//  YLEventMaker.m
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "YLEventMaker.h"
@interface YLEventMaker()
@property (nonatomic, strong) NSMutableSet<YLEvent *>* madeEvents;
@end
@implementation YLEventMaker
#pragma mark - init

- (YLEvent *)after {
    return self.generateEvent.after;
}
- (YLEvent *)instead {
    return self.generateEvent.instead;
}
- (YLEvent *)before {
    return self.generateEvent.before;
}
- (YLEvent *)automaticRemoval {
    return self.generateEvent.automaticRemoval;
}

- (YLEvent *)generateEvent {
    YLEvent *event = [[YLEvent alloc] init];
    [self.madeEvents addObject:event];
    return event;
}

- (YLEvent *(^)(NSString *selectorName))selector {
    return ^id(NSString *selectorName) {
        return YLEvent.new.selector(selectorName);
    };
}

- (NSMutableSet<YLEvent *> *)madeEvents {
    if (_madeEvents == nil) {
        _madeEvents = [[NSMutableSet alloc] init];
    }
    return _madeEvents;
}

- (NSArray<YLEvent *> *)events {
    return [self.madeEvents allObjects];
}
@end
