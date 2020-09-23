//
//  BSCommentModel.h
//  CommentDemo
//
//  Created by xu sancai on 2020/9/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BSCommentItemModel.h"
#define BS_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

NS_ASSUME_NONNULL_BEGIN

@interface BSCommentModel : NSObject

/// 发布人的昵称
@property (nonatomic, copy) NSString * name;

/// 用户发布的内容
@property (nonatomic, copy) NSString * content;

/// 用户头像
@property (nonatomic, copy) NSString * img;

/// 点赞数量
@property (nonatomic, copy) NSString * num;
/// 发布时间
@property (nonatomic, copy) NSString * time;

/// 其他用户评论
@property (nonatomic, strong) NSArray * comments;

@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat contentHeight;

+ (NSArray *)commentList;
@end

NS_ASSUME_NONNULL_END
