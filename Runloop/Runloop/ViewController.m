//
//  ViewController.m
//  Runloop
//
//  Created by xu sancai on 2020/9/11.
//  Copyright © 2020 xu sancai. All rights reserved.
//

#import "ViewController.h"
#import "BSPermenantThreadViewController.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton * pushLongThreadButton;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Runloop 应用场景";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pushLongThreadButton];

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

@end
