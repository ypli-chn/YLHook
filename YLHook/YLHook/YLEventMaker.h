//
//  YLEventMaker.h
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLEvent.h"
@interface YLEventMaker : NSObject
- (YLEvent *(^)(NSString *selectorName))selector;
- (YLEvent *)after;
- (YLEvent *)instead;
- (YLEvent *)before;
- (YLEvent *)automaticRemoval;
- (NSArray<YLEvent *> *)events;
@end
