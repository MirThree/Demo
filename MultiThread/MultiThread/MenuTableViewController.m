//
//  MenuTableViewController.m
//  MultiThread
//
//  Created by xu sancai on 2020/9/15.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "MenuTableViewController.h"
#import "GCDController.h"
#import "NSOperationController.h"
#import "NSThreadController.h"

@interface MenuTableViewController ()

@property (nonatomic, strong) NSArray * dataList;
@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多线程";
    _dataList = @[@"GCD",@"NSOperation",@"NSThread"];
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
    if ([string isEqualToString:@"GCD"]) {
        GCDController * gcdC = [[GCDController alloc] init];
        [self.navigationController pushViewController:gcdC animated:true];
    }
    else if ([string isEqualToString:@"NSOperation"]) {
        NSOperationController * vc = [[NSOperationController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
    else if ([string isEqualToString:@"NSThread"]) {
        NSThreadController * vc = [[NSThreadController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}
@end
