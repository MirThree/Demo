//
//  BSCommentModel.m
//  CommentDemo
//
//  Created by xu sancai on 2020/9/23.
//

#import "BSCommentModel.h"

@interface BSCommentModel ()

@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, assign, readwrite) CGFloat contentHeight;

@end
@implementation BSCommentModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _height = -30;
        _contentHeight = 0;
    }
    return self;
}
- (CGFloat)contentHeight {
    if (_contentHeight <= 0) {
        if (_content && _content.length > 0) {
            CGFloat temp = 0;
            temp = [_content boundingRectWithSize:CGSizeMake(BS_SCREEN_WIDTH - 45, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
            
            _contentHeight += temp;
        }
    }
    return _contentHeight;
}
- (CGFloat)height {
    if (_height < 0) {
        _height = 12 + 30 + 16 + 12;
        _height += self.contentHeight;
        
        if (_comments && _comments.count > 0) {
            CGFloat temp = 24;
            for (NSInteger i = 0; i < _comments.count; i++) {
                BSCommentItemModel * item = _comments[i];
                temp += ([item commentHeight:CGSizeMake(BS_SCREEN_WIDTH - 77, 1000)] + 19);
            }
            _height += temp;
        }
        return  _height;
        
        
    }else {
        return  _height;
    }
}
+ (NSArray *)commentList {
    
    NSMutableArray * array = [NSMutableArray array];
    BSCommentModel * model = [[BSCommentModel alloc] init];
    model.name = @"野结衣";
    model.content = @"hello 大家好热情啊";
    model.img = @"cat.jpg";
    model.num = @"99";
    model.comments = [BSCommentItemModel itemList];
    model.time = @"刚刚";
    [array addObject:model];
    model = [[BSCommentModel alloc] init];
    model.name = @"野结衣";
    model.content = @"hello 大家好";
    model.img = @"cat.jpg";
    model.num = @"66";
    model.comments = [BSCommentItemModel itemList];
    model.time = @"一小时前";

    [array addObject:model];

    model = [[BSCommentModel alloc] init];
    model.name = @"野结衣";
    model.content = @"hello 大家太好了";
    model.img = @"cat.jpg";
    model.num = @"77";
    model.comments = [BSCommentItemModel itemList];
    model.time = @"二小时前";

    [array addObject:model];

    model = [[BSCommentModel alloc] init];
    model.name = @"野结衣";
    model.content = @"hello 大家晚上好";
    model.img = @"cat.jpg";
    model.num = @"88";
    model.time = @"三小时前";

    model.comments = [BSCommentItemModel itemList];
    [array addObject:model];

    model = [[BSCommentModel alloc] init];
    model.name = @"野结衣";
    model.content = @"hello 大家晚上好";
    model.img = @"cat.jpg";
    model.num = @"88";
    model.time = @"四小时前";
    model.comments = @[];
    [array addObject:model];
    
    
    return array;
}
@end
