//
//  BSPermenantThread.h
//  Runloop
//
//  Created by xu sancai on 2020/9/11.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BSPermenantThreadTask) (void);
@interface BSPermenantThread : NSObject

/// 在当前子线程执行一个任务
/// @param task 任务
- (void)executeTask:(BSPermenantThreadTask)task;

/// 结束线程
- (void)stop;
@end

NS_ASSUME_NONNULL_END
