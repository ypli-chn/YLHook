//
//  YLEvent.m
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "YLEvent.h"

@interface YLEvent()
@property (nonatomic, assign) AspectOptions option;
@property (nonatomic, copy) id handlerBlock;
@property (nonatomic) SEL hookSelector;
@end
@implementation YLEvent
#pragma mark - 

- (YLEvent *)after {
    self.option = AspectPositionAfter;
    return self;
}

- (YLEvent *)instead {
    self.option = AspectPositionInstead;
    return self;
}

- (YLEvent *)before {
    self.option = AspectPositionBefore;
    return self;
}

- (YLEvent *)automaticRemoval {
    self.option = AspectOptionAutomaticRemoval;
    return self;
}

- (YLEvent *(^)(NSString *))selector {
    return ^id(NSString * selectorName) {
        self.hookSelector = NSSelectorFromString(selectorName);
        return self;
    };
}

- (YLEvent *(^)(id blk))block {
    return ^id(id blk) {
        self.handlerBlock = blk;
        return self;
    };
}

@end
