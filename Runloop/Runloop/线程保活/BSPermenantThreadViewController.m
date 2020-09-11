//
//  LongThreadViewController.m
//  Runloop
//
//  Created by xu sancai on 2020/9/11.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "BSPermenantThreadViewController.h"
#import "BSPermenantThread.h"
@interface BSPermenantThreadViewController ()
@property (nonatomic, strong) BSPermenantThread * thread;

@end

@implementation BSPermenantThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"线程保活";
    self.view.backgroundColor = [UIColor whiteColor];
    self.thread = [[BSPermenantThread alloc] init];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.thread stop];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.thread executeTask:^{
      NSLog(@"执行任务 - %@", [NSThread currentThread]);
  }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}
@end
