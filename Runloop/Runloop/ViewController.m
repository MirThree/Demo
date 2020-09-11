//
//  ViewController.m
//  Runloop
//
//  Created by xu sancai on 2020/9/11.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "ViewController.h"
#import "BSPermenantThreadViewController.h"
#import "BSFluecyMonitorViewController.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton * pushLongThreadButton;
@property (nonatomic, strong) UIButton * pushFluecyMonitorButton;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Runloop 应用场景";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pushLongThreadButton];
    [self.view addSubview:self.pushFluecyMonitorButton];

}

- (UIButton *)pushLongThreadButton {
    if (!_pushLongThreadButton) {
        _pushLongThreadButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 100, 200, 50)];
        _pushLongThreadButton.backgroundColor = [UIColor orangeColor];
        [_pushLongThreadButton setTitle:@"线程保活" forState:UIControlStateNormal];
        [_pushLongThreadButton addTarget:self action:@selector(pushLongThreadController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushLongThreadButton;
}
- (void)pushLongThreadController {
    BSPermenantThreadViewController * controller = [[BSPermenantThreadViewController alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}
- (UIButton *)pushFluecyMonitorButton {
    if (!_pushFluecyMonitorButton) {
        _pushFluecyMonitorButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 170, 200, 50)];
        _pushFluecyMonitorButton.backgroundColor = [UIColor orangeColor];
        [_pushFluecyMonitorButton setTitle:@"卡顿检测" forState:UIControlStateNormal];
        [_pushFluecyMonitorButton addTarget:self action:@selector(pushFluecyMonitorController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushFluecyMonitorButton;
}
- (void)pushFluecyMonitorController {
    BSFluecyMonitorViewController * controller = [[BSFluecyMonitorViewController alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}

@end
