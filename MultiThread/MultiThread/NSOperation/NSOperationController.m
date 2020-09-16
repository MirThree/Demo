//
//  NSOperationController.m
//  MultiThread
//
//  Created by xu sancai on 2020/9/16.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "NSOperationController.h"
#import "WHOperation.h"

@interface NSOperationController ()

@property (nonatomic, strong) NSArray * dataList;
@end

@implementation NSOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSOperation";
    _dataList = @[@"NSInvocationOperation的使用",@"NSBlockOperation的使用",@"运用继承自NSOperation的子类",@"addExecutionBlock:实现多线程",@"addOperation把任务添加到队列",@"addOperationWithBlock把任务添加到队列",@"NSOperation线程间通信",@"最大并发数",@"操作依赖"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    [self.tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    cell.textLabel.text = _dataList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * string = _dataList[indexPath.row];
//    _dataList = @[@"NSInvocationOperation的使用",@"NSBlockOperation的使用",@"运用继承自NSOperation的子类",@"addExecutionBlock:实现多线程",@"addOperation把任务添加到队列",@"addOperationWithBlock把任务添加到队列 ",@"NSOperation线程间通信",@"最大并发数",@"操作依赖"];

    if ([string isEqualToString:@"NSInvocationOperation的使用"]) {
        [self testNSInvocationOperation];
    }
    else if ([string isEqualToString:@"NSBlockOperation的使用"]) {
        [self testNSBlockOperation];
    }
    else if ([string isEqualToString:@"运用继承自NSOperation的子类"]) {
        [self testWHOperation];
    }
    else if ([string isEqualToString:@"addExecutionBlock:实现多线程"]) {
        [self testNSBlockOperationExecution];
    }
    else if ([string isEqualToString:@"addOperation把任务添加到队列"]) {
        [self testAddOperation];
    }
    else if ([string isEqualToString:@"addOperationWithBlock把任务添加到队列"]) {
        [self testAddOperationWithBlock];
    }
    else if ([string isEqualToString:@"NSOperation线程间通信"]) {
        [self communicationBetweenThreadAction];
    }
    else if ([string isEqualToString:@"最大并发数"]) {
        [self testMaxConcurrentOperationCount];
    }
    else if ([string isEqualToString:@"操作依赖"]) {
        [self testAddDependency];
    }

    
}
- (void)testNSInvocationOperation {
    NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation) object:nil];
    [operation start];
}
- (void)invocationOperation {
    NSLog(@"NSInvocationOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
}


- (void)testNSBlockOperation {
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
    }];
    [operation start];
}
- (void)testWHOperation {
    WHOperation *operation = [[WHOperation alloc] init];
    [operation start];
}
- (void)testNSBlockOperationExecution {
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"NSBlockOperation运用addExecutionBlock========%@", [NSThread currentThread]);

    }];
    [operation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务1========%@", [NSThread currentThread]);
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"1 %s  %zd",__func__,i);
        }

    }];
    [operation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务2========%@", [NSThread currentThread]);
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"2 %s  %zd",__func__,i);
        }
    }];
    [operation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务3========%@", [NSThread currentThread]);
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"3 %s  %zd",__func__,i);
        }

    }];
    [operation start];
    
}
- (void)testAddOperation {
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation * invocationOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationAddOperation) object:nil];
    NSBlockOperation * blockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"addOperation把任务添加到队列======%@", [NSThread currentThread]);
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"4 %s  %zd",__func__,i);
        }
    }];
    [queue addOperation:invocationOp];
    [queue addOperation:blockOp];
    
}
- (void)invocationOperationAddOperation {
    NSLog(@"invocationOperation===addOperation把任务添加到队列==========%@", [NSThread currentThread]);
}

- (void)testAddOperationWithBlock {
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    NSLog(@"==========================");
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"5 %s  %zd  %@",__func__,i, [NSThread currentThread]);
        }
    }];
}
- (void)communicationBetweenThreadAction {
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        sleep(5);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.view.backgroundColor = [UIColor orangeColor];
        }];
    }];
}
- (void)testMaxConcurrentOperationCount {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    queue.maxConcurrentOperationCount = 1;
    
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<100; i++) {
            NSLog(@"6 %s  %zd  %@",__func__,i, [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<150; i++) {
            NSLog(@"7 %s  %zd  %@",__func__,i, [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<200; i++) {
            NSLog(@"8 %s  %zd  %@",__func__,i, [NSThread currentThread]);
        }
    }];
}

- (void)testAddDependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i<200; i++) {
            NSLog(@"9 %s  %zd  %@",__func__,i, [NSThread currentThread]);
        }
    }];
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i<50; i++) {
            NSLog(@"10 %s  %zd  %@",__func__,i, [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation * op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"开始执行 op3---------------");
        for (NSInteger i = 0; i<300; i++) {
            NSLog(@"11 %s  %zd  %@",__func__,i, [NSThread currentThread]);
        }
    }];
    
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];

}

@end
