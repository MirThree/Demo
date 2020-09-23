//
//  BSCommentItemModel.h
//  CommentDemo
//
//  Created by xu sancai on 2020/9/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BSCommentItemModel : NSObject

/// 评论人的名字
@property (nonatomic, copy) NSString * name;
/// 被评论人的名字
@property (nonatomic, copy) NSString * commentName;
/// 多久前评论的
@property (nonatomic, copy) NSString * time;
/// 品论的内容
@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy, readonly) NSAttributedString * fullComment;
@property (nonatomic, assign, readonly) CGFloat height;
- (CGFloat)commentHeight:(CGSize)size;
+ (NSArray *)itemList;
@end

NS_ASSUME_NONNULL_END
