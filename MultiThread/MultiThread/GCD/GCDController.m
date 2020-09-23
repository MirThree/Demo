//
//  GCDController.m
//  MultiThread
//
//  Created by xu sancai on 2020/9/15.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "GCDController.h"

@interface GCDController ()

@property (nonatomic, strong) NSArray * dataList;
@end

@implementation GCDController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GCD";
    _dataList = @[@"串行同步",@"串行异步",@"并发同步",@"并发异步",@"主队列同步",@"主队列异步",@"GCD线程之间的通信",@"GCD栅栏",@"GCD延时执行",@"GCD快速迭代",@"GCD队列组",@"信号量",@"依赖关系"];
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
//    _dataList = @[@"串行同步",@"串行异步",@"并发同步",@"并发异步",@"主队列同步",@"主队列异步",@"GCD线程之间的通信",@"GCD栅栏",@"GCD延时执行",@"GCD快速迭代",@"GCD队列组"];

    if ([string isEqualToString:@"串行同步"]) {
        [self syncSerial];
    }
    else if ([string isEqualToString:@"串行异步"]) {
        [self asyncSerial];
    }
    else if ([string isEqualToString:@"并发同步"]) {
        [self syncConcurrent];
    }
    else if ([string isEqualToString:@"并发异步"]) {
        [self asyncConcurrent];
    }
    else if ([string isEqualToString:@"主队列同步"]) {
        [self syncMain];
    }
    else if ([string isEqualToString:@"主队列异步"]) {
        [self asyncMain];
    }
    else if ([string isEqualToString:@"GCD线程之间的通信"]) {
        [self communicationBetweenThread];
    }
    else if ([string isEqualToString:@"GCD栅栏"]) {
        [self barrierGCD];
    }
    else if ([string isEqualToString:@"GCD延时执行"]) {
        [self gcdAfter];
    }
    else if ([string isEqualToString:@"GCD快速迭代"]) {
        [self applyGCD];
    }
    else if ([string isEqualToString:@"GCD队列组"]) {
        [self groupGCD];
    }
    else if ([string isEqualToString:@"信号量"]) {
        [self testSemaphore];
    }
    else if ([string isEqualToString:@"依赖关系"]) {
        [self testDependencyGCD];
    }
}

//MARK:- 串行同步
- (void)syncSerial {
    NSLog(@"\n\n**************串行同步***************\n\n");

    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    // dispatch_sync 不开辟新的线程
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"串行同步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"串行同步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"串行同步3   %@",[NSThread currentThread]);
        }
    });
    
}
//MARK:- 串行异步
- (void)asyncSerial {
    NSLog(@"\n\n**************串行异步***************\n\n");
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步3   %@",[NSThread currentThread]);
        }
    });
    
}
//MARK:- 并发同步
- (void)syncConcurrent {
    NSLog(@"\n\n**************并发同步***************\n\n");
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步3   %@",[NSThread currentThread]);
        }
    });
}
//MARK:- 并发异步
- (void)asyncConcurrent {
    NSLog(@"\n\n**************并发异步***************\n\n");

    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    // 同步执行
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步3   %@",[NSThread currentThread]);
        }
    });
    
}
//MARK:- 主队列同步
- (void)syncMain {
    NSLog(@"\n\n**************主队列同步 闪退***************\n\n");

    dispatch_queue_t queue = dispatch_get_main_queue();
    // 同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步3   %@",[NSThread currentThread]);
        }
    });
    
}
//MARK:- 主队列异步
- (void)asyncMain {
    NSLog(@"\n\n**************主队列异步 类似串行***************\n\n");

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"主队列异步1   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"主队列异步2   %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 20; i++) {
            NSLog(@"主队列异步3   %@",[NSThread currentThread]);
        }
    });
    
}
//MARK:- 线程间通信
- (void)communicationBetweenThread {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:3];
        //异步处理复杂逻辑
        dispatch_async(dispatch_get_main_queue(), ^{
            //在主线程上面刷新UI
            self.view.backgroundColor = [UIColor orangeColor];
        });
    });
}
//MARK: gcd 队列
- (void)groupGCD {
    NSLog(@"\n\n**************gcd 队列***************\n\n");

    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组1：有一个耗时操作完成！");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组2：有一个耗时操作完成！");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组3：有一个耗时操作完成！");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"队列组：前面的耗时操作都完成了，回到主线程进行相关操作");
    });
}

//MARK: gcd 快速迭代
- (void)applyGCD {
    NSLog(@"\n\n**************gcd 快速迭代***************\n\n");

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_apply(7, queue, ^(size_t index) {
        NSLog(@"dispatch_apply：%zd======%@",index, [NSThread currentThread]);
    });
}
//MARK: gcd 栅栏
- (void)barrierGCD {
    NSLog(@"\n\n**************gcd 栅栏***************\n\n");
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
             NSLog(@"栅栏：并发异步1   %@",[NSThread currentThread]);
         }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步2   %@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_sync(queue, ^{
        NSLog(@"------------barrier------------%@", [NSThread currentThread]);
        NSLog(@"******* 并发异步执行，但是34一定在12后面 *********");
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
             NSLog(@"栅栏：并发异步3   %@",[NSThread currentThread]);
         }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步4   %@",[NSThread currentThread]);
        }
    });
    

}

//MARK: gcd 延时执行
- (void)gcdAfter {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 5秒后异步执行
        NSLog(@"我已经等待了5秒！");
    });
//    GCD实现代码只执行一次
//    使用dispatch_once能保证某段代码在程序运行过程中只被执行1次。可以用来设计单例。
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"程序运行过程中我只执行了一次！");
//    });
}
- (void)testSemaphore {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("semaphore", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 请求完成，可以通知界面刷新界面等操作
            NSLog(@"第一步网络请求完成1");
            // 使信号的信号量+1，这里的信号量本来为0，+1信号量为1(绿灯)
            dispatch_semaphore_signal(semaphore);
        }];
        [task resume];
        // 以下还要进行一些其他的耗时操作
        NSLog(@"1耗时操作继续进行");
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(group, queue, ^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.github.com"]];
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 请求完成，可以通知界面刷新界面等操作
            NSLog(@"第一步网络请求完成2");
            // 使信号的信号量+1，这里的信号量本来为0，+1信号量为1(绿灯)
            dispatch_semaphore_signal(semaphore);
        }];
        [task resume];
        // 以下还要进行一些其他的耗时操作
        NSLog(@"2耗时操作继续进行");
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"刷新界面等在主线程的操作");
    });
}
- (void)testDependencyGCD {
    // 创建分组
    dispatch_group_t group = dispatch_group_create();
    // 创建队列
    dispatch_queue_t queue = dispatch_queue_create("queus", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"1111111 %@",[NSThread currentThread]);

    });

    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"222222 %@",[NSThread currentThread]);
    });

    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"333333 %@",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"完成 --- %@",[NSThread currentThread]);
    });
}
@end
