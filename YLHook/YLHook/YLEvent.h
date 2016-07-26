//
//  YLEvent.h
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Aspects.h>
@interface YLEvent : NSObject
@property (nonatomic, assign, readonly) AspectOptions option;
@property (nonatomic, copy, readonly) id handlerBlock;
@property (nonatomic, readonly) SEL hookSelector;

- (YLEvent *(^)(NSString *selectorName))selector;
- (YLEvent *(^)(id blk))block;
- (YLEvent *)after;
- (YLEvent *)instead;
- (YLEvent *)before;
- (YLEvent *)automaticRemoval;

@end
