//
//  BSFluecyMonitorViewController.m
//  Runloop
//
//  Created by xu sancai on 2020/9/11.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "BSFluecyMonitorViewController.h"
#import "LXDBacktraceLogger.h"
#import "LXDAppFluecyMonitor.h"

@interface BSFluecyMonitorViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation BSFluecyMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LXDAppFluecyMonitor sharedMonitor] startMonitoring];

    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"cell"];
    }
    return _tableView;
}
- (void)viewDidAppear: (BOOL)animated {
    [super viewDidAppear: animated];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return 1000;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    cell.textLabel.text = [NSString stringWithFormat: @"%lu", indexPath.row];
    if (indexPath.row > 0 && indexPath.row % 30 == 0) {
//        usleep(2000000);
        sleep(2.0);
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
//    for (int idx = 0; idx < 100; idx++) {
////        usleep(10000);
//    }
    
    
    sleep(2.0);
}
@end
