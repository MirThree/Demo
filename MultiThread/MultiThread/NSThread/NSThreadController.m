//
//  NSThreadController.m
//  MultiThread
//
//  Created by xu sancai on 2020/9/16.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "NSThreadController.h"

@interface NSThreadController ()

@property (nonatomic, strong) NSArray * dataList;
@end

@implementation NSThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSThread";
    _dataList = @[@"init",@"detachNewThreadSelector",@"performSelectorInBackground"];
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
//    _dataList = @[@"init",@"detachNewThreadSelector",@"performSelectorInBackground"];

    if ([string isEqualToString:@"init"]) {
        NSThread * t = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1:) object:@"init方式"];
        [t start];
    }else if ([string isEqualToString:@"detachNewThreadSelector"]) {
        [NSThread  detachNewThreadSelector:@selector(doSomething2:) toTarget:self withObject:@"detachNewThreadSelector方式"];
    }
    else if ([string isEqualToString:@"performSelectorInBackground"]) {
        [self performSelectorInBackground:@selector(doSomething3:) withObject:@"performSelectorInBackground"];

    }

    
}

- (void)doSomething1:(NSObject *)object {
    // 传递过来的参数
    NSLog(@"%@",object);
    NSLog(@"doSomething1：%@",[NSThread currentThread]);
}

- (void)doSomething2:(NSObject *)object {
    NSLog(@"%@",object);
    NSLog(@"doSomething2：%@",[NSThread currentThread]);
}

- (void)doSomething3:(NSObject *)object {
    NSLog(@"%@",object);
    NSLog(@"doSomething3：%@",[NSThread currentThread]);
}

@end
