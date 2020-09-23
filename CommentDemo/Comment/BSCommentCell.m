//
//  BSCommentCell.m
//  CommentDemo
//
//  Created by xu sancai on 2020/9/23.
//

#import "BSCommentCell.h"
@interface BSCommentCell ()

@property (nonatomic, strong) UIImageView * avaterImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) UIButton * voteButton;
@property (nonatomic, strong) UIView * commentsView;

@property (nonatomic, strong) NSMutableArray<UILabel *> * views;
@end

@implementation BSCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _views = [[NSMutableArray alloc] init];
        [self createSubviews];
        
    }
    return  self;
}
- (void)createSubviews {
    _avaterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 12, 30, 30)];
    [self.contentView addSubview:_avaterImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avaterImageView.frame.size.width + _avaterImageView.frame.origin.x + 10, 16, 200, 12)];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_nameLabel];

    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avaterImageView.frame.size.width + _avaterImageView.frame.origin.x + 10, _nameLabel.frame.origin.y + _nameLabel.frame.size.height + 5, 200, 10)];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont systemFontOfSize:8];
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, _avaterImageView.frame.origin.y + _avaterImageView.frame.size.height + 17, BS_SCREEN_WIDTH - 21 - 23, 14)];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_contentLabel];
    _commentsView = [[UIView alloc] initWithFrame:CGRectZero];

    _commentsView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    [self.contentView addSubview:_commentsView];
}
- (void)setCommentModel:(BSCommentModel *)commentModel {
    _nameLabel.text = commentModel.name;
    _timeLabel.text = commentModel.time;
    _contentLabel.text = commentModel.content;
    _avaterImageView.image = [UIImage imageNamed:commentModel.img];
    _contentLabel.frame = CGRectMake(21, _avaterImageView.frame.origin.y + _avaterImageView.frame.size.height + 17, BS_SCREEN_WIDTH - 21 - 23, commentModel.contentHeight);
    if (commentModel.comments && commentModel.comments.count > 0){
        _commentsView.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.size.height + _contentLabel.frame.origin.y + 12, BS_SCREEN_WIDTH - 22-22, commentModel.height - (_contentLabel.frame.size.height + _contentLabel.frame.origin.y + 12 + 12));
        [self clearComments];

        UILabel * nextLabel;
        for (NSInteger i = 0; i < commentModel.comments.count; i++) {
            BSCommentItemModel * item = commentModel.comments[i];
            NSLog(@"%@",item);
            if (nextLabel) {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(18.5, nextLabel.frame.size.height + nextLabel.frame.origin.y + 19, _commentsView.frame.size.width - 18.5 - 13.5, item.height)];
                label.attributedText = item.fullComment;
                NSLog(@"item.height=%lf",item.height);
                label.numberOfLines = 0;
//                label.backgroundColor = [UIColor orangeColor];
                label.font = [UIFont systemFontOfSize:14];
                [_commentsView addSubview:label];
                [_views addObject:label];
                nextLabel = label;
            }else {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(18.5, 12, _commentsView.frame.size.width - 18.5 - 13.5, item.height)];
                label.numberOfLines = 0;
                label.font = [UIFont systemFontOfSize:14];

                label.attributedText = item.fullComment;
                [_commentsView addSubview:label];
                nextLabel = label;
                [_views addObject:label];
            }
            
        }
    }else {
        [self clearComments];
        _commentsView.frame = CGRectZero;
    }
}
- (void)clearComments {
    for (NSInteger i = 0; i < _views.count; i++) {
        UILabel * label = _views[i];
        [label removeFromSuperview];
        label = nil;
    }
    [_views removeAllObjects];
    NSLog(@"_views = %@",_views);
}

@end
