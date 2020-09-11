//
//  BSPermenantThread.m
//  Runloop
//
//  Created by xu sancai on 2020/9/11.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "BSPermenantThread.h"

@interface BSThread : NSThread
@end
@implementation BSThread
- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end


@interface BSPermenantThread()
@property (nonatomic, strong) BSThread * innerThread;
@end


@implementation BSPermenantThread

- (void)dealloc {
    NSLog(@"%s", __func__);
}

-(instancetype)init {
    if (self = [super init]) {
        self.innerThread = [[BSThread alloc] initWithBlock:^{
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext content = {0};
            
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &content);
            
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            
            // 销毁source
            CFRelease(source);
            
            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            NSLog(@"end ---- ");
        }];
        self.innerThread.name = @"innerThread";
        [self.innerThread start];
    }
    return self;
}

- (void)executeTask:(BSPermenantThreadTask)task {
    if (!self.innerThread || !task) return;
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:YES];

}
- (void)stop {
    if (!self.innerThread) return;
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}
//MARK: - 私有方法
- (void)__stop {
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}
- (void)__executeTask:(BSPermenantThreadTask)task {
    task();
}
@end
