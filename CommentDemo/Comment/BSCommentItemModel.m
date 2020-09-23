//
//  BSCommentItemModel.m
//  CommentDemo
//
//  Created by xu sancai on 2020/9/23.
//

#import "BSCommentItemModel.h"
@interface BSCommentItemModel ()
@property (nonatomic, copy, readwrite) NSAttributedString * fullComment;
@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, assign) CGSize preSize;

@end
@implementation BSCommentItemModel
- (CGFloat)commentHeight:(CGSize)size {
    if (!CGSizeEqualToSize(_preSize, size)) {
        
        CGSize  temp = [self.fullComment boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _preSize = size;
        _height = temp.height;
        NSLog(@"%@ --------- %lf\n",self.fullComment,_height);
        return  temp.height;
    }
    return  _height;

}
- (NSAttributedString *)fullComment {
    if (_fullComment != nil) {return  _fullComment;}
    NSLog(@"222222222222222222");
    NSString * fullString = @"";
    if (_commentName == nil) {
        fullString = [NSString stringWithFormat:@"%@：%@ %@",_name,_content,_time];
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:fullString];
        NSRange range = NSMakeRange(0, _name.length+1);

        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]} range:range];
        
        range = NSMakeRange(_name.length + 1, _content.length);

        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14], NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:range];
        
        range = NSMakeRange(_name.length + _content.length + 3 - 1, _time.length);

        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11], NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]} range:range];
        
        _fullComment = string;
    }else {
        fullString = [NSString stringWithFormat:@"%@ 回复 %@：%@ %@",_name,_commentName,_content,_time];

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:fullString];
        NSRange range = NSMakeRange(0, _name.length);

        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]} range:range];

        range = NSMakeRange(_name.length+1, 2);
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14], NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:range];
        

        range = NSMakeRange(_name.length + 2 + 2, _commentName.length+1);
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]} range:range];

        
        range = NSMakeRange(_name.length + _commentName.length + 2 + 3, _content.length);
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14], NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]} range:range];
        
        range = NSMakeRange(_name.length + _commentName.length + _content.length + 2 + 4, _time.length);
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11], NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]} range:range];
        _fullComment = string;
    }
    
    return  _fullComment;
    
}
+ (NSArray *)itemList {
    NSMutableArray * array = [NSMutableArray array];
    BSCommentItemModel * model = [[BSCommentItemModel alloc] init];
    model.name = @"小婊砸";
    model.content = @"这个问题有问题,这个问题有问题,这个问题有问题,这个问题有问题,这个问题有问题这个问题有问题,这个问题有问题,这";
    model.time = @"一天前";
    [array addObject:model];
    model = [[BSCommentItemModel alloc] init];
    model.commentName = @"小婊砸";
    model.name = @"小胖子";
    model.content = @"这是你的问题";
    model.time = @"2小时前";

    [array addObject:model];

    model = [[BSCommentItemModel alloc] init];
    model.name = @"小凳子";
    model.content = @"可以认识一下大神吗";
    model.time = @"1分钟前";

    [array addObject:model];

    
    model = [[BSCommentItemModel alloc] init];
    model.name = @"小桌子";
    model.content = @"这是一个严肃的问题";
    model.time = @"4小时前";

    [array addObject:model];

    return array;
}
@end
