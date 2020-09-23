//
//  BSCommentTableViewController.m
//  CommentDemo
//
//  Created by xu sancai on 2020/9/23.
//

#import "BSCommentTableViewController.h"
#import "BSCommentCell.h"

@interface BSCommentTableViewController ()
@property (nonatomic, strong) NSArray * dataList;
@end

@implementation BSCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    self.view.backgroundColor = [UIColor orangeColor];
    [self.tableView registerClass:[BSCommentCell class] forCellReuseIdentifier:@"BSCommentCell"];
    [self.tableView reloadData];
    self.tableView.tableFooterView = [UIView new];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _dataList = [BSCommentModel commentList];
    NSLog(@"--%@",_dataList);
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"111111== %@",_dataList);
    return _dataList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCommentModel * model = _dataList[indexPath.row];
    NSLog(@"-----%lf",model.height);
    return model.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BSCommentCell"];
    cell.commentModel = _dataList[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}
@end
